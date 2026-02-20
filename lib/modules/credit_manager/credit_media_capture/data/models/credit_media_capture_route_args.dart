import 'dart:ui';

class CreditMediaCaptureRouteArgs {
  final String fileType;
  final String category;
  final bool isSingle;
  final VoidCallback onFinalRoute;

  const CreditMediaCaptureRouteArgs({
    required this.fileType,
    required this.category,
    this.isSingle = false,
    required this.onFinalRoute,
  });
}
