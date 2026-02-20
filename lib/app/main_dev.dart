import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import '../services/sentry_service.dart';
import 'main_app_builder.dart';
import 'main_app_runner.dart';

void main() async {
  const env = Environment.dev;
  final runner = MainAppRunner(environment: env);
  const builder = MainAppBuilder();

  FlutterError.onError =
      (FlutterErrorDetails details) async => await captureException(
            details,
            releaseMode: false,
          );

  runner.run(builder);
}
