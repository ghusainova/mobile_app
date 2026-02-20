import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../components/router/data/routes.dart';
import '../../../../../../components/widgets/buttons/blue_button.dart';
import '../../../../../../components/widgets/buttons/outlined_blue_button.dart';
import '../../../../../../components/widgets/dialog_widget.dart';
import '../../../../../../components/widgets/snackbar/snackbar.dart';
import '../../../../../../config/injectable/injectable.dart';
import '../../../../complete_client_session/domain/bloc/complete_client_session_bloc.dart';
import '../../../../login/domain/auth/auth_bloc.dart' as ab;
import '../../../../queue/domain/bloc/queue_bloc.dart' as qb;
import 'feedback_modal.dart';
import 'queue_ip_address_widget.dart';

class ProfileBtnsWidget extends StatelessWidget {
  const ProfileBtnsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt.get<CompleteClientSessionBloc>(),
      child:
          BlocConsumer<CompleteClientSessionBloc, CompleteClientSessionState>(
        listener: (context, state) => state.whenOrNull(
          completed: () => _onLogOut(context),
          error: (error) => showSnackBar(context, error),
        ),
        builder: (context, state) => Column(
          children: [
            const QueueIpAddressWidget(),
            OutlinedBlueButton(
              margin: const EdgeInsets.only(bottom: 16),
              text: 'Сообщите об ошибках',
              onPressed: () => _showFeedmackModal(context),
            ),
            OutlinedBlueButton(
              text: 'Сменить пароль',
              disabled: state is qb.Loading,
              onPressed: _onChangePassword,
            ),
            BlueButton(
              text: 'Выйти',
              isLoading: state is qb.Loading,
              onPressed: () => _logOut(context),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onChangePassword() async {
    final url = Uri.parse('https:///);
    await launchUrl(url, mode: LaunchMode.externalApplication);
  }

  void _logOut(BuildContext context) {
    if (getIt.get<qb.QueueBloc>().activeClient != null) {
      showDialog(
        context: context,
        builder: (_) => DialogWidget(
          alertTitle: 'Вы уверены, что хотите завершить работу с клиентом?',
          submitBtnTitle: 'Да, завершить',
          declineBtnTitle: 'Вернуться к обслуживанию',
          onSubmit: () {
            context.pop();
            getIt.get<CompleteClientSessionBloc>().add(
                  const CompleteClientSession(
                    reason: 'Другое',
                    comment: 'Принудительное завершение работы',
                    disableQueueRefresh: true,
                  ),
                );
          },
          onDecline: () => context.pop(),
        ),
      );
    } else {
      _onLogOut(context);
    }
  }

  void _onLogOut(BuildContext context) {
    context.read<ab.AuthBloc>().add(const ab.LogoutUser());
    const LoginRoute().go(context);
  }

  void _showFeedmackModal(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
      context: context,
      isScrollControlled: true,
      builder: (_) => const FeedbackModal(),
    );
  }
}
