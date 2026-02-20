import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/injectable/injectable.dart';
import '../../../../../../components/router/data/routes.dart';
import '../../../../../../components/styles/app_colors.dart';
import '../../../../../../components/widgets/appbar/appbar_widget.dart';
import '../../../../../../components/widgets/snackbar/snackbar.dart';
import '../../../../shared/_helpers/appbar_back_btn_dialog.dart';
import '../../../data/enum/inspection_item_enum.dart';
import '../../../data/models/equipment_inspection.dart';
import '../../../domain/equipment_inspection/equipment_inspection_bloc.dart';
import 'widgets/wheels_content_widget.dart';

class WheelsInspectionFormPage extends StatefulWidget {
  final InspectionItemEnum inspectionItem;

  const WheelsInspectionFormPage(this.inspectionItem, {super.key});

  @override
  State<WheelsInspectionFormPage> createState() =>
      _WheelsInspectionFormPageState();
}

class _WheelsInspectionFormPageState extends State<WheelsInspectionFormPage> {
  final bloc = getIt.get<EquipmentInspectionBloc>();
  EquipmentInspection? data;

  @override
  void initState() {
    super.initState();
    initBloc();
  }

  @override
  void dispose() {
    saveData();
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        widget.inspectionItem.stageName,
        onCloseBtnTap: () => onCloseBtnDialog(context),
      ),
      backgroundColor: AppColors.backBase,
      body: BlocProvider.value(
        value: bloc,
        child: BlocConsumer<EquipmentInspectionBloc, EquipmentInspectionState>(
          listener: (context, state) => state.whenOrNull(
            loaded: onDataUpdated,
            saved: onSaved,
            error: onError,
          ),
          builder: (context, state) {
            if (data != null) {
              return WheelsContentWidget(
                equipmentInspection: data!,
                inspectionItem: widget.inspectionItem,
                onRefresh: initBloc,
                onDataUpdated: onDataUpdated,
                onSubmit: onSubmit,
              );
            }

            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  Future<void> initBloc() async {
    bloc.add(
      Load(type: widget.inspectionItem.type),
    );
  }

  void onDataUpdated(EquipmentInspection updatedData) {
    data = updatedData;
  }

  void onSaved() {
    if (widget.inspectionItem == InspectionItemEnum.tires) {
      const WheelsInspectionFormRoute(InspectionItemEnum.rims).push(context);
    } else {
      const MainInspectionFormRoute(InspectionItemEnum.bodyFrame).push(context);
    }
  }

  void onError(String? message) {
    showSnackBar(context, message);
  }

  void onSubmit() {
    if (data?.hasEmptyFields ?? false) {
      showSnackBar(context, 'Заполните обязательные поля');
      return;
    }

    saveData(toggleNextStage: true);
  }

  void saveData({bool toggleNextStage = false}) {
    final stageName = toggleNextStage ? widget.inspectionItem.stageName : null;

    if (data != null) {
      bloc.add(
        Save(body: data!, stageName: stageName),
      );
    }
  }
}
