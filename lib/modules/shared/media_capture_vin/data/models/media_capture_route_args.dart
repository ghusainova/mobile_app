import 'dart:ui';

class MediaCaptureRouteArgs {
  final String? caseId;
  final bool saveHistoryStage;
  final VoidCallback onFinalRoute;

  const MediaCaptureRouteArgs({
    required this.caseId,
    required this.onFinalRoute,
    this.saveHistoryStage = false,
  });
}
