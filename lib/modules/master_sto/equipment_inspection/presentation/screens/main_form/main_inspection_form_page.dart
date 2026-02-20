import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../components/widgets/appbar/appbar_close_action_widget.dart';
import '../../../../../../config/injectable/injectable.dart';
import '../../../../../../components/router/app_router.dart';
import '../../../../../../components/router/data/routes.dart';
import '../../../../../../components/styles/app_colors.dart';
import '../../../../../../components/widgets/appbar/appbar_widget.dart';
import '../../../../../../components/widgets/no_content_widget.dart';
import '../../../../../../components/widgets/snackbar/snackbar.dart';
import '../../../../shared/_helpers/appbar_back_btn_dialog.dart';
import '../../../../../../services/sentry_service.dart';
import '../../../../scan_cases/domain/scan_cases/scan_cases_bloc.dart' as sc;
import '../../../data/enum/inspection_item_enum.dart';
import '../../../data/models/equipment_inspection.dart';
import '../../../domain/equipment_inspection/equipment_inspection_bloc.dart';
import 'widgets/app_bar_scroll_btn_widget.dart';
import 'widgets/main_inspection_content_widget.dart';

class MainInspectionFormPage extends StatefulWidget {
  final InspectionItemEnum inspectionItem;

  const MainInspectionFormPage(this.inspectionItem, {super.key});

  @override
  State<MainInspectionFormPage> createState() => _MainInspectionFormPageState();
}

class _MainInspectionFormPageState extends State<MainInspectionFormPage> {
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
        customActions: getCustomActions(),
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
            if (state is Error) {
              return NoContentWidget(
                onRefresh: initBloc,
                errorMessage: state.message,
              );
            }

            if (data != null) {
              return MainInspectionContentWidget(
                inspectionItem: widget.inspectionItem,
                equipmentInspection: data!,
                onRefresh: initBloc,
                onDataUpdated: onDataUpdated,
                onSubmit: validateAndSave,
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

  void onError(String? message) {
    showSnackBar(context, message);
  }

  void onDataUpdated(EquipmentInspection updatedData) {
    data = updatedData;
  }

  void validateAndSave() async {
    final imageValidationCount = data?.imageUploadValidationCount ?? 0;
    final uploadedImagesCount = bloc.mediaFiles.length;
    final isParking = getIt.get<sc.ScanCasesBloc>().scanCase?.isParking;

    if (isParking == false && imageValidationCount > uploadedImagesCount) {
      showSnackBar(context, 'Загрузите фото дефектов');
      await captureSentryEvent('Загрузите фото дефектов', data?.toJson());
      return;
    }

    if ((data?.hasEmptyFields ?? false)) {
      showSnackBar(context, 'Заполните обязательные поля');
      await captureSentryEvent('Заполните обязательные поля', data?.toJson());
      return;
    }

    if ((data?.hasEmptyPaintwork ?? false)) {
      showSnackBar(context, 'Заполните данные по ЛКП');
      await captureSentryEvent('Заполните данные по ЛКП', data?.toJson());
      return;
    }

    saveData(toggleNextStage: true);
  }

  void saveData({bool toggleNextStage = false}) {
    final stageName = toggleNextStage ? widget.inspectionItem.stageName : null;

    if ((!bloc.isClosed && bloc.state is! Loading) && data != null) {
      bloc.add(
        Save(body: data!, stageName: stageName),
      );
    }
  }

  void onSaved() {
    final nextInspectionItem = getNextInspectionItem(widget.inspectionItem);

    if (!mounted) return;

    if (nextInspectionItem == null) {
      const HistoryRoute(isFinalStage: true).go(context);
      return;
    }

    if (nextInspectionItem.clearPrevRouteStack) {
      AppRouter().router.customPushAndRemoveUntil(
            () => MainInspectionFormRoute(nextInspectionItem).push(context),
          );
    } else {
      MainInspectionFormRoute(nextInspectionItem).push(context);
    }
  }

  List<Widget> getCustomActions() {
    return [
      const AppBarScrollBtnWidget(),
      AppBarCloseActionWidget(onPressed: () => onCloseBtnDialog(context)),
    ];
  }
}
