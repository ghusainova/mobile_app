import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../config/injectable/injectable.dart';
import '../config/logs/log.dart';
import '../modules/master_sto/scan_cases/domain/scan_cases/scan_cases_bloc.dart';
import '../modules/shared/login/domain/user/user_bloc.dart';

Future<void> captureSentryEvent(String errorType, dynamic data) async {
  final user = getIt.get<UserBloc>().user;
  final errorDetails = {
    'username': '${user?.userFirstName} ${user?.userLastName}',
    'caseId': getIt.get<ScanCasesBloc>().scanCase?.caseId,
    'errorType': errorType,
    'data': data,
  }.toString();

  await Sentry.captureMessage(errorDetails);
}

Future<void> captureException(
  FlutterErrorDetails errorDetails, {
  bool releaseMode = true,
}) async {
  if (_ignoreErrorMessage(errorDetails)) return;

  logger.e(errorDetails);

  if (releaseMode) {
    await Sentry.captureException(
      errorDetails.exception,
      stackTrace: errorDetails.stack,
    );
  }
}

bool _ignoreErrorMessage(FlutterErrorDetails errorDetails) {
  final exceptionString = errorDetails.exception.toString();
  final ignoredMessages = [
    'https:/prod/',
    'Unable to load asset',
    'Failed to decode image',
  ];

  return ignoredMessages.any((message) => exceptionString.contains(message));
}
