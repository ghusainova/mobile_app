import 'dart:ui';

import '../../../../../components/router/app_router.dart';
import '../../../../../components/router/data/routes.dart';
import '../../../../../config/injectable/injectable.dart';
import '../../../credit_application/domain/credit_application/credit_application_bloc.dart';
import '../../../credit_media_capture/data/constants/credit_inspection_info_items.dart';
import '../../../credit_media_capture/data/enums/vin_credit_media_file_type_enum.dart';
import '../../../credit_media_capture/data/models/credit_media_capture_route_args.dart';
import '../../../credit_media_capture/data/models/credit_photo_inspection_args.dart';

final _context = rootNavigatorKey.currentContext;

void navigateCreditRegCertInspection({VoidCallback? onFinalRoute}) {
  if (_context != null) {
    final args = CreditPhotoInspectionArgs(
      title: 'Фото техпаспорта',
      subtitle: 'Сделайте фото техпаспорта',
      category: 'REGCERT',
      inspectionInfoItems: creditRegCertInspectionItems,
      onSubmit: onFinalRoute ??
          () => const CreditAdditionalInfoRoute().push(_context!),
    );
    CreditPhotoInspectionRoute(args).push(_context!);
  }
}

void navigateCreditVinVideo({VoidCallback? onFinalRoute}) {
  if (_context != null) {
    final args = CreditMediaCaptureRouteArgs(
      fileType: VinCreditMediaFileTypeEnum.video.fileType,
      category: VinCreditMediaFileTypeEnum.video.category,
      onFinalRoute: onFinalRoute ?? navigateCreditVinPhoto,
    );

    CreditVideoCaptureVinRoute(args).push(_context!);
  }
}

void navigateCreditVinPhoto({VoidCallback? onFinalRoute}) {
  if (_context != null) {
    final args = CreditMediaCaptureRouteArgs(
      fileType: VinCreditMediaFileTypeEnum.photo.fileType,
      category: VinCreditMediaFileTypeEnum.photo.category,
      onFinalRoute: onFinalRoute ?? navigateCreditBodyPhotoInspection,
    );

    CreditPhotoCaptureVinRoute(args).push(_context!);
  }
}

void navigateCreditBodyPhotoInspection({VoidCallback? onFinalRoute}) {
  if (_context != null) {
    final args = CreditPhotoInspectionArgs(
      title: 'Фото кузова',
      subtitle: 'Сделайте фото кузова внутри бокса',
      category: 'BODY',
      inspectionInfoItems: creditExteriorInspectionItems,
      showAdditionalPhotoBtn: true,
      onSubmit: onFinalRoute ?? navigateCreditInteriorPhotoInspection,
    );
    CreditPhotoInspectionRoute(args).push(_context!);
  }
}

void navigateCreditInteriorPhotoInspection({VoidCallback? onFinalRoute}) {
  if (_context != null) {
    final args = CreditPhotoInspectionArgs(
      title: 'Фото салона',
      subtitle: 'Сделайте фото салона',
      btnTitle: 'Завершить фотографирование',
      category: 'INTERIOR',
      inspectionInfoItems: creditInteriorInspectionItems,
      showAdditionalPhotoBtn: true,
      onSubmit: () => getIt
          .get<CreditApplicationBloc>()
          .add(const CompletePhotoInspection()),
    );
    CreditPhotoInspectionRoute(args).push(_context!);
  }
}
