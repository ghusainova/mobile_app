import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../config/injectable/injectable.dart';
import '../config/app/app_builder.dart';
import '../modules/shared/login/domain/auth/auth_bloc.dart';
import '../modules/shared/login/domain/user/user_bloc.dart';
import '../modules/shared/queue/domain/bloc/queue_bloc.dart';
import '../components/router/app_router.dart';
import 'kolesa_manager_app.dart';

class MainAppBuilder implements AppBuilder {
  const MainAppBuilder();

  @override
  Widget buildApp() {
    return SafeArea(
      top: false,
      child: MultiBlocProvider(
        providers: [
          BlocProvider.value(
            value: getIt.get<AuthBloc>()..add(const Started()),
          ),
          BlocProvider.value(value: getIt.get<UserBloc>()),
          BlocProvider.value(value: getIt.get<QueueBloc>()),
        ],
        child: KolesaManagerApp(appRouter: AppRouter()),
      ),
    );
  }
}
