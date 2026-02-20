import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../_data/helpers/display_mode_init.dart';
import '../../data/enum/user_role_enum.dart';
import '../../data/models/user/token.dart';
import '../../data/models/user/user_roles.dart';
import '../../../../../components/widgets/appbar/appbar_widget.dart';
import '../../../../../components/widgets/snackbar/snackbar.dart';
import '../../domain/auth/auth_bloc.dart';
import 'widgets/login_form_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    setOptimalDisplayMode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget('Вход', showBackButton: false),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) => state.whenOrNull(
          error: (message) => _showMessage(context, message),
          authorizedState: (token) => _onAuthorizedState(context, token),
        ),
        builder: (context, state) =>
            state.whenOrNull(
              initial: (login) => LoginFormWidget(
                login: login,
                onTap: (login, passsowrd) => _onAuth(context, login, passsowrd),
              ),
            ) ??
            const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  void _onAuth(BuildContext context, String login, String passsowrd) {
    if (login.isEmpty || passsowrd.isEmpty) {
      _showMessage(context, 'Заполните все поля');
      return;
    }

    context.read<AuthBloc>().add(LoginUser(login: login, password: passsowrd));
  }

  void _onAuthorizedState(BuildContext context, Token token) {
    _showMessage(context, 'Вход выполнен');
    _selectRoleRoute(context, token);
  }

  void _selectRoleRoute(BuildContext context, Token token) {
    final currentUserRole = manageUserRoles(token.accessToken);

    if (currentUserRole == null) {
      showSnackBar(context, 'Конфликт ролей, обратитесь к администратору');
      return;
    }

    context.go(currentUserRole.routePath);
  }

  void _showMessage(BuildContext context, String? message) {
    showSnackBar(context, message ?? '');
  }
}
