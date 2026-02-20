import '../../../../config/injectable/injectable.dart';
import '../../../../components/router/app_router.dart';
import '../../../../components/router/data/routes.dart';
import '../../../shared/media_capture_vin/data/models/media_capture_route_args.dart';
import '../../scan_cases/domain/scan_cases/scan_cases_bloc.dart';

mixin class MediaArgs {
  MediaCaptureRouteArgs getMasterCaptureArgs() {
    final context = rootNavigatorKey.currentContext;
    final caseId = getIt.get<ScanCasesBloc>().scanCase?.caseId;
    final args = MediaCaptureRouteArgs(
      caseId: caseId,
      saveHistoryStage: true,
      onFinalRoute: () {
        if (context != null) {
          const AdditionalInfoRoute().push(context);
        }
      },
    );

    return args;
  }
}
