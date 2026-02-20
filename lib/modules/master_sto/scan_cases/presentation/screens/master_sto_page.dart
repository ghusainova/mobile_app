import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../components/router/data/routes.dart';
import '../../../../../config/injectable/injectable.dart';
import '../../../../../components/router/back_btn_interceptor.dart';
import '../../../../../components/styles/app_colors.dart';
import '../../../../../components/widgets/appbar/appbar_widget.dart';
import '../../../../../components/widgets/no_content_widget.dart';
import '../../../../../components/widgets/snackbar/snackbar.dart';
import '../../../shared/_helpers/master_sto_injection_cfg.dart';
import '../../domain/scan_cases/scan_cases_bloc.dart';
import 'scan_cases_content/scan_cases_content.dart';

class MasterStoPage extends StatefulWidget {
  const MasterStoPage({super.key});

  @override
  State<MasterStoPage> createState() => _MasterStoPageState();
}

class _MasterStoPageState extends State<MasterStoPage> {
  @override
  void initState() {
    super.initState();
    registerMasterStoInjection();
    addBackBtnInterceptor(context);
    load();
  }

  @override
  void dispose() {
    removeBackBtnInterceptor(context);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        null,
        showBackButton: false,
        showUserData: true,
      ),
      backgroundColor: AppColors.backBase,
      resizeToAvoidBottomInset: false,
      body: BlocProvider.value(
        value: getIt.get<ScanCasesBloc>(),
        child: BlocConsumer<ScanCasesBloc, ScanCasesState>(
          listener: (context, state) => state.whenOrNull(
            gotInWork: onGotInWork,
            error: showMessage,
          ),
          builder: (context, state) =>
              state.whenOrNull(
                loading: () => const Center(child: CircularProgressIndicator()),
                loaded: (cases) => RefreshIndicator(
                  onRefresh: load,
                  child: const ScanCasesContent(),
                ),
                noContent: () => NoContentWidget(onRefresh: load),
              ) ??
              const SizedBox(),
        ),
      ),
    );
  }

  Future<void> load() async {
    getIt.get<ScanCasesBloc>().add(const Load());
  }

  void showMessage(String? message) {
    showSnackBar(context, message);
  }

  void onGotInWork(bool? isCaseInProgress) {
    if (isCaseInProgress == true) {
      const HistoryRoute().push(context);
    } else {
      const MainInfoRoute().push(context);
    }
  }
}
