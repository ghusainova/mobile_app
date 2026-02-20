import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../components/router/data/routes.dart';
import '../../../../../components/styles/app_colors.dart';
import '../../../../../components/widgets/appbar/appbar_widget.dart';
import '../../../../../config/injectable/injectable.dart';
import '../../../../shared/queue/domain/bloc/queue_bloc.dart';
import '../../domain/credit_application/credit_application_bloc.dart';
import 'widgets/credit_application_page_content.dart';

class CreditApplicationPage extends StatefulWidget {
  const CreditApplicationPage({super.key});

  @override
  State<CreditApplicationPage> createState() => _CreditApplicationPageState();
}

class _CreditApplicationPageState extends State<CreditApplicationPage> {
  @override
  void initState() {
    super.initState();
    getCreditApplication();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        'Оформление Автокредита',
        showBackButton: false,
      ),
      backgroundColor: AppColors.backBase,
      body: BlocConsumer<QueueBloc, QueueState>(
        listener: (context, state) => state.whenOrNull(
          fetchingQueue: (_) => const CreditQueueRoute().go(context),
        ),
        builder: (context, state) => CreditApplicationPageContent(
          () => getCreditApplication(refresh: true),
        ),
      ),
    );
  }

  Future<void> getCreditApplication({bool refresh = false}) async {
    if (refresh) {
      getIt.get<QueueBloc>().add(const GetManagerState(refresh: true));
    }

    getIt
        .get<CreditApplicationBloc>()
        .add(const GetCreditApplicationOrder(getStatusList: true));
  }
}
