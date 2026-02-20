import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/injectable/injectable.dart';
import '../../../../../components/router/data/routes.dart';
import '../../../../../components/widgets/appbar/appbar_widget.dart';
import '../../../../../components/widgets/no_content_widget.dart';
import '../../../../../components/widgets/snackbar/snackbar.dart';
import '../../../shared/_helpers/appbar_back_btn_dialog.dart';
import '../../../scan_cases/domain/scan_cases/scan_cases_bloc.dart' as sc;
import '../../../shared/_helpers/media_capture_args.dart';
import '../../data/models/main_info.dart';
import '../../domain/main_info/main_info_bloc.dart';
import 'widgets/main_info_content.dart';

class MainInfoPage extends StatefulWidget {
  const MainInfoPage({super.key});

  @override
  State<MainInfoPage> createState() => _MainInfoPageState();
}

class _MainInfoPageState extends State<MainInfoPage> with MediaArgs {
  final bloc = getIt.get<MainInfoBloc>();
  MainInfo? mainInfo;

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
        child: BlocConsumer<MainInfoBloc, MainInfoState>(
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

            if (mainInfo != null) {
              return RefreshIndicator(
                onRefresh: load,
                child: MainInfoContent(mainInfo: mainInfo!),
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
    bloc.add(const MainInfoEvent.load());
  }

  void save() {
    bloc.add(const MainInfoEvent.save());
  }

  void onError(String? message) {
    showSnackBar(context, message);
  }

  void onLoaded(MainInfo loadedInfo) {
    mainInfo = loadedInfo;
  }

  void onSaved() {
    final isParking = getIt.get<sc.ScanCasesBloc>().scanCase?.isParking;
    mainInfo = bloc.mainInfo;

    if (isParking == true) {
      const AdditionalInfoRoute().push(context);
    } else {
      VideoCaptureVinRoute(getMasterCaptureArgs()).push(context);
    }
  }
}
