import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../components/widgets/no_content_widget.dart';
import '../../../../queue/data/models/branch_user.dart';

import '../../../../../../config/injectable/injectable.dart';
import '../../../data/enums/branch_user_queue_type_enum.dart';
import '../../../../../../components/widgets/appbar/appbar_widget.dart';
import '../../../../../../components/widgets/buttons/blue_button.dart';
import '../../../../../../components/widgets/snackbar/snackbar.dart';
import '../../../domain/bloc/complete_client_session_bloc.dart';
import 'widgets/completing_items_tile_widget.dart';

class ClientRedirectPage extends StatefulWidget {
  final VoidCallback onSubmit;
  const ClientRedirectPage(this.onSubmit, {super.key});

  @override
  State<ClientRedirectPage> createState() => _ClientRedirectPageState();
}

class _ClientRedirectPageState extends State<ClientRedirectPage> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget('Перенаправить клиента'),
      body: BlocProvider.value(
        value: getIt.get<CompleteClientSessionBloc>(),
        child:
            BlocConsumer<CompleteClientSessionBloc, CompleteClientSessionState>(
          listener: (context, state) => state.whenOrNull(
            completed: onComplete,
            error: showError,
          ),
          builder: (context, state) =>
              state.whenOrNull(
                branchLoaded: (users) => Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          'Выберите сотрудника',
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ),
                      CompletingTileItemsWidget(
                        users: users,
                        onSelect: (index) => selectedIndex = index,
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: BlueButton(
                          text: 'Перенаправить клиента',
                          onPressed: () => redirectClient(users),
                        ),
                      ),
                    ],
                  ),
                ),
                error: (message) => NoContentWidget(
                  errorMessage: message,
                  onRefresh: load,
                ),
              ) ??
              const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }

  void load() {
    getIt.get<CompleteClientSessionBloc>().add(const GetQueueBranch());
  }

  void redirectClient(List<BranchUser> users) {
    final branchUser =
        users.length > selectedIndex ? users[selectedIndex] : null;

    if (branchUser?.queueType?.code != null &&
        branchUser?.tableNumber != null) {
      getIt.get<CompleteClientSessionBloc>().add(
            RedirectClient(
              queueType: branchUser!.queueType!.code!,
              tableNumber: branchUser.tableNumber!,
            ),
          );
    } else {
      showError('No queue type or table number found for this user');
      return;
    }
  }

  void onComplete() {
    widget.onSubmit();

    WidgetsBinding.instance.addPostFrameCallback(
      (_) => showSnackBar(context, 'Клиент перенаправлен'),
    );
  }

  void showError(String? message) {
    showSnackBar(context, message ?? 'Ошибка');
  }
}
