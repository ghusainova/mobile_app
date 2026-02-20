import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/injectable/injectable.dart';
import '../../../modules/shared/login/data/models/user/user.dart';
import '../../../modules/shared/login/domain/user/user_bloc.dart';

class AppbarTitleWidget extends StatelessWidget {
  final String? title;
  final Color? textColor;

  const AppbarTitleWidget(
    this.title, {
    super.key,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) => Text(
        _getTitle(),
        style: Theme.of(context)
            .textTheme
            .headlineSmall!
            .copyWith(color: textColor),
      ),
    );
  }

  String _getTitle() {
    final user = getIt.get<UserBloc>().user;
    final userCredentials = getUserCredentials(user) ?? '';

    return title ?? userCredentials;
  }
}
