import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../components/router/back_btn_interceptor.dart';
import '../../../../../components/router/data/routes.dart';
import '../../../../../components/widgets/appbar/appbar_widget.dart';
import '../../../../../components/widgets/snackbar/snackbar.dart';
import '../../../../shared/queue/domain/bloc/queue_bloc.dart';
import '../../../../shared/queue/presentation/screens/call_new_client_from_queue/call_new_client_widget.dart';
import '../../../../shared/queue/presentation/screens/service_unavailable_widget.dart';
import '../../../shared/_data/helpers/credit_manager_injection_cfg.dart';

class CreditQueuePage extends StatefulWidget {
  const CreditQueuePage({super.key});

  @override
  State<CreditQueuePage> createState() => _CreditQueuePageState();
}

class _CreditQueuePageState extends State<CreditQueuePage> {
  @override
  void initState() {
    super.initState();
    registerCreditManagerInjection();
    addBackBtnInterceptor(context);
    getManagerState();
  }

  @override
  void dispose() {
    removeBackBtnInterceptor(context);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(null, showBackButton: false),
      body: BlocConsumer<QueueBloc, QueueState>(
        listener: (context, state) => state.whenOrNull(
          handlingClient: (_) => const CreditApplicationRoute().go(context),
          error: (message, showCustomMessage) => showSnackBar(context, message),
        ),
        builder: (context, state) =>
            state.whenOrNull(
              fetchingQueue: (length) =>
                  CallNewClientWidget(queueLength: length ?? 0),
              error: (message, showCustomMessage) => ServiceUnavailableWidget(
                message: message,
                showCustomMessage: showCustomMessage,
                onTap: getManagerState,
              ),
            ) ??
            const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  void getManagerState() {
    context.read<QueueBloc>().add(const GetManagerState());
  }

  void showErrorSnackbar(String? message) {
    showSnackBar(
      context,
      message,
      duration: const Duration(seconds: 5),
      onTapEnabled: true,
    );
  }
}
