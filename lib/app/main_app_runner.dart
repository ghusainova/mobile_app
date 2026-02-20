import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../config/injectable/injectable.dart';
import '../config/app/app_builder.dart';
import '../config/app/app_runner.dart';

class MainAppRunner implements AppRunner {
  final String environment;

  MainAppRunner({required this.environment});

  @override
  Future<void> preloadData() async {
    WidgetsFlutterBinding.ensureInitialized();
    HttpOverrides.global = MyHttpOverrides();
    configureInjection(environment);
    initializeDateFormatting();
  }

  @override
  Future<void> run(AppBuilder appBuilder) async {
    await preloadData();
    runApp(appBuilder.buildApp());
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
