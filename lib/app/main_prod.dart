import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../modules/shared/_data/constants/api_keys.dart';
import '../services/sentry_service.dart';
import 'main_app_builder.dart';
import 'main_app_runner.dart';

void main() async {
  const env = Environment.prod;

  final runner = MainAppRunner(environment: env);
  const builder = MainAppBuilder();

  FlutterError.onError =
      (FlutterErrorDetails details) async => await captureException(details);

  await SentryFlutter.init(
    (options) {
      options.dsn = sentryDsn;
      options.tracesSampleRate = 1.0;
      options.anrEnabled = true;
      // options.debug = true;
    },
    appRunner: () => runner.run(builder),
  );
}
