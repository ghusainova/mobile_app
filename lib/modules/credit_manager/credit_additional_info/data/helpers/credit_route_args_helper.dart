import '../../../../../components/router/app_router.dart';
import '../../../../../components/router/data/routes.dart';
import '../../../../shared/car_photo_inspection/data/constants/car_photo_inspection_route_args.dart';

void getCreditPhotoInspectionRoute(String? orderId) {
  final context = rootNavigatorKey.currentContext;

  if (context != null) {
    final exArgs = exteriorInspectionArgs.copyWith(
      caseId: orderId,
      onSubmit: () => const CreditApplicationRoute().go(context),
    );

    CarPhotoInspectionRoute(exArgs).push(context);
  }
}
