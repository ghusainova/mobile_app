import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../components/widgets/appbar/appbar_widget.dart';
import '../../../../../components/widgets/buttons/blue_button.dart';
import '../../../../../config/injectable/injectable.dart';
import '../../data/enum/user_role_enum.dart';
import '../../domain/user/user_bloc.dart';

class UserRoleSelectionPage extends StatelessWidget {
  const UserRoleSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget('Выбрать роль', showBackButton: false),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: UserRoleEnum.values
              .where((element) => element != UserRoleEnum.admin)
              .map(
                (e) => BlueButton(
                  text: e.label,
                  onPressed: () => _onSelectRole(context, e),
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  void _onSelectRole(BuildContext context, UserRoleEnum role) {
    getIt.get<UserBloc>().add(UpdateUserRole(role));
    context.go(role.routePath);
  }
}
