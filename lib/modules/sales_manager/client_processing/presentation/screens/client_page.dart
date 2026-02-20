import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../components/router/back_btn_interceptor.dart';
import '../../../../../components/styles/app_colors.dart';
import '../../../../../components/widgets/appbar/appbar_widget.dart';
import '../../../../../components/widgets/snackbar/snackbar.dart';
import '../../../../shared/queue/domain/bloc/queue_bloc.dart';
import '../../../../shared/queue/presentation/screens/call_new_client_from_queue/call_new_client_widget.dart';
import '../../../shared/_data/helpers/sales_manager_injection_cfg.dart';
import 'handling_client/work_with_client_widget.dart';
import '../../../../shared/queue/presentation/screens/service_unavailable_widget.dart';

class ClientPage extends StatefulWidget {
  const ClientPage({super.key});

  @override
  State<ClientPage> createState() => _ClientPageState();
}

class _ClientPageState extends State<ClientPage> {
  @override
  void initState() {
    super.initState();
    registerSalesManagerInjection();
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
      backgroundColor: AppColors.backBase,
      appBar: const AppBarWidget(
        null,
        showBackButton: false,
        showUserData: true,
      ),
      body: BlocConsumer<QueueBloc, QueueState>(
        listener: (context, state) => state.whenOrNull(
          error: (message, _) => showErrorSnackbar(message),
        ),
        builder: (context, state) {
          if (state is FetchingQueue) {
            return CallNewClientWidget(queueLength: state.length ?? 0);
          } else if (state is HandlingClient) {
            return WorkWithClientWidget(state.activeClient);
          } else if (state is Error) {
            return ServiceUnavailableWidget(
              message: state.message,
              showCustomMessage: state.showCustomMessage,
              onTap: getManagerState,
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
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
