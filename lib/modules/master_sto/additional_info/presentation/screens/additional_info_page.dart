import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/injectable/injectable.dart';
import '../../../../../components/router/app_router.dart';
import '../../../../../components/router/data/routes.dart';
import '../../../../../components/widgets/appbar/appbar_widget.dart';
import '../../../../../components/widgets/no_content_widget.dart';
import '../../../../../components/widgets/snackbar/snackbar.dart';
import '../../../shared/_helpers/appbar_back_btn_dialog.dart';
import '../../../../shared/additional_info/data/enums/additional_info_param_enum.dart';
import '../../../defect_inspection/_shared/data/enum/car_body_part.dart';
import '../../data/models/additional_info.dart';
import '../../domain/additional_info/additional_info_bloc.dart';
import 'widgets/additional_info_content.dart';

class AdditionalInfoPage extends StatefulWidget {
  const AdditionalInfoPage({super.key});

  @override
  State<AdditionalInfoPage> createState() => _AdditionalInfoPageState();
}

class _AdditionalInfoPageState extends State<AdditionalInfoPage> {
  final bloc = getIt.get<AdditionalInfoBloc>();
  AdditionalInfo? additionalInfo;
  List<String>? engineVolumes;

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
        'Осмотр авто',
        onCloseBtnTap: () => onCloseBtnDialog(context),
      ),
      body: BlocProvider.value(
        value: bloc,
        child: BlocConsumer<AdditionalInfoBloc, AdditionalInfoState>(
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

            if (additionalInfo != null && engineVolumes != null) {
              return RefreshIndicator(
                onRefresh: load,
                child: AdditionalInfoContent(
                  additionalInfo: additionalInfo!,
                  engineVolumes: engineVolumes!,
                  onSave: () => save(setStage: true),
                  onChangeInfo: onChangeInfo,
                  isLoading: state is Loading,
                ),
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  Future<void> load() async {
    bloc.add(const AdditionalInfoEvent.load());
  }

  void save({bool setStage = false}) {
    bloc.add(AdditionalInfoEvent.save(setStage: setStage));
  }

  void onSaved() {
    if (mounted) {
      AppRouter().router.customPushAndRemoveUntil(
            () => const CarBodyDefectsRoute(CarBodyPart.roof).push(context),
          );
    }
  }

  void onError(String? message) {
    showSnackBar(context, message);
  }

  void onLoaded(AdditionalInfo loadedAddInfo, List<String>? volumes) {
    additionalInfo = loadedAddInfo;
    engineVolumes = volumes;
  }

  void onChangeInfo(AdditionalInfoParamEnum param, String value) {
    bloc.add(
      AdditionalInfoEvent.changeAdditionalInfo(
        param: param,
        value: value,
      ),
    );
  }
}
