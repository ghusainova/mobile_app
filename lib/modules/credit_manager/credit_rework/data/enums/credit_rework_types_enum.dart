import 'dart:ui';

import 'package:go_router/go_router.dart';

import '../../../../../components/router/app_router.dart';
import '../../../../../components/router/data/routes.dart';
import '../../../../../components/styles/app_assets.dart';
import '../../../shared/_data/helpers/credit_route_args.dart';

final _context = rootNavigatorKey.currentContext;

enum CreditReworkItemType {
  editSellerData,
  techPassportPhoto,
  additionalInfo,
  vin,
  exteriorPhoto,
  interiorPhoto,
  other,
}

extension CreditReworkItemTypeExt on CreditReworkItemType {
  String get title {
    switch (this) {
      case CreditReworkItemType.techPassportPhoto:
        return 'Фото техпаспорта';
      case CreditReworkItemType.editSellerData:
        return 'Данные продавца и авто';
      case CreditReworkItemType.additionalInfo:
        return 'Доп. информация об авто';
      case CreditReworkItemType.exteriorPhoto:
        return 'Фото кузова авто';
      case CreditReworkItemType.interiorPhoto:
        return 'Фото салона авто';
      case CreditReworkItemType.vin:
        return 'Фото-видео VIN-кода';
      case CreditReworkItemType.other:
        return 'OTHER';
    }
  }

  String get code {
    switch (this) {
      case CreditReworkItemType.editSellerData:
        return 'EDIT_SELLER_DATA';
      case CreditReworkItemType.techPassportPhoto:
        return 'TECH_PASSPORT_PHOTO';
      case CreditReworkItemType.additionalInfo:
        return 'ADDITIONAL_INFO';
      case CreditReworkItemType.exteriorPhoto:
        return 'EXTERIOR_PHOTO';
      case CreditReworkItemType.interiorPhoto:
        return 'INTERIOR_PHOTO';
      case CreditReworkItemType.vin:
        return 'VIN';
      case CreditReworkItemType.other:
        return 'OTHER';
    }
  }

  VoidCallback get onRouteNav {
    switch (this) {
      case CreditReworkItemType.editSellerData:
        return () {
          if (_context != null) {
            const EditSellerDataRoute().push(_context!);
          }
        };
      case CreditReworkItemType.techPassportPhoto:
        return () {
          if (_context != null) {
            navigateCreditRegCertInspection(
              onFinalRoute: () => _context!.pop(),
            );
          }
        };
      case CreditReworkItemType.additionalInfo:
        return () {
          if (_context != null) {
            const CreditAdditionalInfoRoute().push(_context!);
          }
        };
      case CreditReworkItemType.vin:
        return () {
          if (_context != null) {
            navigateCreditVinVideo(
              onFinalRoute: () => _context!.pop(),
            );
          }
        };
      case CreditReworkItemType.exteriorPhoto:
        return () {
          if (_context != null) {
            navigateCreditBodyPhotoInspection(
              onFinalRoute: () => _context!.pop(),
            );
          }
        };
      case CreditReworkItemType.interiorPhoto:
        return () {
          if (_context != null) {
            navigateCreditInteriorPhotoInspection(
              onFinalRoute: () => _context!.pop(),
            );
          }
        };
      case CreditReworkItemType.other: //TODO
        return () {};
    }
  }

  String get iconPath {
    switch (this) {
      case CreditReworkItemType.editSellerData:
      case CreditReworkItemType.additionalInfo:
      case CreditReworkItemType.techPassportPhoto:
        return AppAssets.additinalInfo;
      case CreditReworkItemType.exteriorPhoto:
      case CreditReworkItemType.interiorPhoto:
        return AppAssets.bodyInspection;
      case CreditReworkItemType.vin:
        return AppAssets.videoInspection;
      case CreditReworkItemType.other:
        return 'OTHER';
    }
  }
}
