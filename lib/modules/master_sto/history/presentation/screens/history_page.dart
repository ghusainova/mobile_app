import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../components/router/data/routes.dart';
import '../../../../../components/widgets/appbar/appbar_widget.dart';
import '../../../../../components/widgets/no_content_widget.dart';
import '../../../../../components/widgets/snackbar/snackbar.dart';
import '../../../../../config/injectable/injectable.dart';
import '../../../../buyer_manager/shared/_data/models/status_page_configs.dart';
import '../../../../shared/_data/enums/status_type_enum.dart';
import '../../../scan_cases/data/models/scan_case.dart';
import '../../../scan_cases/domain/scan_cases/scan_cases_bloc.dart' as sc;
import '../../../scan_cases/domain/scan_cases/scan_cases_bloc.dart';
import '../../domain/history/history_bloc.dart';
import 'history_content/history_content.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({required this.isFinalStage, super.key});
  final bool isFinalStage;

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  void initState() {
    super.initState();
    load();
  }

  @override
  void dispose() {
    getIt.get<sc.ScanCasesBloc>().add(const sc.Load());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        'Осмотр авто',
        showBackButton: !widget.isFinalStage,
        onCloseBtnTap: widget.isFinalStage ? routeToMainPage : null,
      ),
      body: BlocProvider.value(
        value: getIt.get<HistoryBloc>(),
        child: BlocConsumer<HistoryBloc, HistoryState>(
          listener: (context, state) {
            state.whenOrNull(
              error: (message) => showSnackBar(context, message ?? ''),
              finished: routeToSuccessFinish,
              canceled: caseIsCanceled,
            );
          },
          builder: (context, state) =>
              state.whenOrNull(
                loading: () => const Center(child: CircularProgressIndicator()),
                loaded: (history) => RefreshIndicator(
                  onRefresh: load,
                  child: HistoryContent(isFinalStage: widget.isFinalStage),
                ),
                error: (message) => NoContentWidget(
                  onRefresh: load,
                  errorMessage: message,
                ),
              ) ??
              const SizedBox(),
        ),
      ),
    );
  }

  Future<void> load() async {
    getIt.get<HistoryBloc>().add(const HistoryEvent.load());
  }

  void routeToMainPage() {
    if (context.mounted) const MasterStoRoute().go(context);
  }

  void routeToSuccessFinish() {
    ScanCase? scanCase = getIt.get<ScanCasesBloc>().scanCase;
    StatusPageConfigs finishCaseConfigs = StatusPageConfigs(
      appBarTitle: 'Осмотр авто',
      title: 'Осмотр  ${scanCase?.brand} ${scanCase?.model} завершен',
      subtitle: scanCase?.isParking == false
          ? 'В течении 10 минут продавцу придет сообщение с результатами проверки авто'
          : null,
      buttonText: 'Вернуться к заявкам',
      routePath: MasterStoRoute.path,
      statusType: StatusTypeEnum.success,
    );
    StatusPageRoute(finishCaseConfigs).go(context);
  }

  void caseIsCanceled() {
    ScanCase? scanCase = getIt.get<ScanCasesBloc>().scanCase;

    StatusPageConfigs cancelConfigs = StatusPageConfigs(
      appBarTitle: 'Осмотр авто',
      title: 'Осмотр  ${scanCase?.brand} ${scanCase?.model} отменен',
      buttonText: 'Вернуться к заявкам',
      routePath: MasterStoRoute.path,
      statusType: StatusTypeEnum.success,
    );
    StatusPageRoute(cancelConfigs).go(context);
  }
}
