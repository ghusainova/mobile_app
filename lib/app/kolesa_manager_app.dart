import 'package:flutter/material.dart';

import '../components/router/app_router.dart';
import '../components/styles/theme.dart';

class KolesaManagerApp extends StatelessWidget {
  KolesaManagerApp({
    required this.appRouter,
    super.key,
  });

  final AppRouter appRouter;
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: mainTheme,
      routerConfig: appRouter.router,
    );
  }
}
