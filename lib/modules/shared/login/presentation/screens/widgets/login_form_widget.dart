import 'package:flutter/material.dart';

import '../../../../../../components/widgets/buttons/blue_button.dart';
import 'login_text_field_widget.dart';
import 'password_text_field_widget.dart';

class LoginFormWidget extends StatefulWidget {
  final String? login;
  final void Function(String login, String password) onTap;

  const LoginFormWidget({
    required this.onTap,
    this.login,
    super.key,
  });

  @override
  State<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  final loginController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if ((widget.login ?? '').isNotEmpty) {
      loginController.text = widget.login!;
    }
  }

  @override
  void dispose() {
    loginController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView(
              children: [
                Text(
                  'Введите логин и пароль',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                LoginTextField(
                  textController: loginController,
                  onClear: onClear,
                ),
                PasswordTextField(textController: passwordController),
              ],
            ),
          ),
          BlueButton(
            text: 'Войти',
            margin: EdgeInsets.zero,
            onPressed: () =>
                widget.onTap(loginController.text, passwordController.text),
          ),
        ],
      ),
    );
  }

  void onClear() {
    loginController.clear();
    passwordController.clear();
  }
}
