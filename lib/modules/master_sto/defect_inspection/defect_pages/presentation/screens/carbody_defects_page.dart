import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/injectable/injectable.dart';
import '../../../../../../components/router/data/routes.dart';
import '../../../../../../components/styles/app_colors.dart';
import '../../../../../../components/widgets/appbar/appbar_widget.dart';
import '../../../../../../components/widgets/no_content_widget.dart';
import '../../../../../../components/widgets/snackbar/snackbar.dart';
import '../../../../shared/_helpers/appbar_back_btn_dialog.dart';
import '../../../_shared/data/enum/car_body_part.dart';
import '../../../_shared/data/models/defect_model.dart';
import '../../domain/defects/defects_bloc.dart';
import 'widgets/defects_content.dart';

class CarBodyDefectsPage extends StatefulWidget {
  final CarBodyPart bodyPart;

  const CarBodyDefectsPage({required this.bodyPart, super.key});

  @override
  State<CarBodyDefectsPage> createState() => _CarBodyDefectsPageState();
}

class _CarBodyDefectsPageState extends State<CarBodyDefectsPage> {
  final bloc = getIt.get<DefectsBloc>();
  DefectModel? defectModel;

  @override
  void initState() {
    super.initState();
    load();
  }

  @override
  void dispose() {
    save();
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        'Осмотр кузова',
        onCloseBtnTap: () => onCloseBtnDialog(context),
      ),
      backgroundColor: AppColors.backBase,
      body: BlocProvider.value(
        value: bloc,
        child: BlocConsumer<DefectsBloc, DefectsState>(
          listener: (context, state) => state.whenOrNull(
            loaded: onLoaded,
            error: onError,
            saved: onSaved,
          ),
          builder: (context, state) {
            if (state is Error) {
              return NoContentWidget(
                onRefresh: load,
                errorMessage: state.message,
              );
            }

            if (defectModel != null) {
              return RefreshIndicator(
                onRefresh: load,
                child: DefectContent(bodyPart: widget.bodyPart),
              );
            }
            if (state is Loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  Future<void> load() async {
    bloc.add(DefectsEvent.load(bodyPart: widget.bodyPart));
  }

  void save() {
    bloc.add(const DefectsEvent.save());
  }

  void onLoaded(DefectModel loadedDefectModel) {
    defectModel = loadedDefectModel;
  }

  void onSaved() {
    final nextCarBodyPart = getNextBodyPart(widget.bodyPart);
    //TODO: refactor
    if (nextCarBodyPart != null) {
      // if (isRemoveRouteStack(nextCarBodyPart)) {
      //   AppRouter()
      //       .router
      //       .customPushAndRemoveUntil(() => routeToNextScreen(nextCarBodyPart));
      // } else {
      routeToNextScreen(nextCarBodyPart);
      // }
    }
  }

  void routeToNextScreen(CarBodyPart nextCarBodyPart) {
    CarBodyDefectsRoute(nextCarBodyPart).push(context);
  }

  bool isRemoveRouteStack(CarBodyPart nextCarBodyPart) {
    return [
      CarBodyPart.frontLights,
      CarBodyPart.leftBackDoor,
      CarBodyPart.trunk,
      CarBodyPart.rightBackDoor,
    ].contains(nextCarBodyPart);
  }

  void onError(String? message) {
    showSnackBar(context, message);
  }
}
