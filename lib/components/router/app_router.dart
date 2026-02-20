import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../config/injectable/injectable.dart';
import '../../modules/shared/login/domain/auth/auth_bloc.dart';
import 'data/routes.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  final GoRouter _router = GoRouter(
    navigatorKey: rootNavigatorKey,
    debugLogDiagnostics: true,
    routes: $appRoutes,
    redirect: (_, __) {
      final currentContext = rootNavigatorKey.currentContext;
      List<String> routeStack = [];

      if (currentContext != null) {
        routeStack = GoRouter.of(currentContext)
            .routerDelegate
            .currentConfiguration
            .matches
            .map((e) => e.matchedLocation)
            .toList();
      }

      final bool loggedIn = getIt.get<AuthBloc>().state.maybeWhen(
            authorizedState: (_) => true,
            orElse: () => false,
          );

      if (!loggedIn && routeStack.isEmpty) {
        return const LoginRoute().location;
      }

      return null;
    },
  );

  GoRouter get router => _router;
}

extension GoRouterExtensions on GoRouter {
  void customPushAndRemoveUntil(VoidCallback callback) {
    final currentContext = rootNavigatorKey.currentContext;

    if (currentContext != null) {
      final routeStack = GoRouter.of(currentContext)
          .routerDelegate
          .currentConfiguration
          .matches
          .map((e) => e.matchedLocation)
          .toList();

      while (currentContext.canPop() &&
          routeStack.isNotEmpty &&
          routeStack.last != HistoryRoute.path) {
        routeStack.removeLast();
        // https://github.com/flutter/flutter/issues/123369
        Navigator.of(currentContext).pop();
      }
    }

    callback();
  }
}
