import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../components/styles/app_colors.dart';
import '../../../../../components/widgets/appbar/appbar_widget.dart';
import '../../../../../components/widgets/snackbar/snackbar.dart';
import '../../../../shared/queue/domain/bloc/queue_bloc.dart';
import '../../../../shared/queue/presentation/screens/call_new_client_from_queue/call_new_client_widget.dart';
import '../../../../shared/queue/presentation/screens/service_unavailable_widget.dart';
import 'widgets/handle_client_application_widget.dart';

class BuyerQueuePage extends StatefulWidget {
  const BuyerQueuePage({super.key});

  @override
  State<BuyerQueuePage> createState() => _BuyerQueuePageState();
}

class _BuyerQueuePageState extends State<BuyerQueuePage> {
  @override
  void initState() {
    super.initState();
    getManagerState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backBase,
      appBar: const AppBarWidget('Выкуп авто', showBackButton: false),
      body: BlocConsumer<QueueBloc, QueueState>(
        listener: (context, state) => state.whenOrNull(
          error: (message, _) => showErrorSnackbar(message),
        ),
        builder: (context, state) =>
            state.whenOrNull(
              fetchingQueue: (length) =>
                  CallNewClientWidget(queueLength: length ?? 0),
              handlingClient: (activeClient) =>
                  HandleClientApplicationWidget(activeClient),
              error: (message, showCustomMessage) => ServiceUnavailableWidget(
                message: message,
                showCustomMessage: showCustomMessage,
                onTap: getManagerState,
              ),
            ) ??
            const Center(
              child: CircularProgressIndicator(),
            ),
      ),
    );
  }

  void getManagerState() {
    context.read<QueueBloc>().add(const GetManagerState());
  }

  void showErrorSnackbar(String? message) {
    showSnackBar(
      context,
      message ?? 'Error',
      duration: const Duration(seconds: 5),
      onTapEnabled: true,
    );
  }
}
