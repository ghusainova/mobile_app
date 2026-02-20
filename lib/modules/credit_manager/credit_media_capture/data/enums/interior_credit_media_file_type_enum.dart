enum InteriorCreditMediaFileTypeEnum {
  frontRow,
  backseat,
  fromBackseat,
  dashboard,
  conditioner,
  transmission,
  additional,
}

extension BranchUserQueueTypeExt on InteriorCreditMediaFileTypeEnum {
  String get category => 'INTERIOR';

  String get fileType {
    switch (this) {
      case InteriorCreditMediaFileTypeEnum.frontRow:
        return 'FRONT_ROW';
      case InteriorCreditMediaFileTypeEnum.backseat:
        return 'BACKSEAT';
      case InteriorCreditMediaFileTypeEnum.fromBackseat:
        return 'FROM_BACKSEAT';
      case InteriorCreditMediaFileTypeEnum.dashboard:
        return 'DASHBOARD';
      case InteriorCreditMediaFileTypeEnum.conditioner:
        return 'CONDITIONER';
      case InteriorCreditMediaFileTypeEnum.transmission:
        return 'TRANSMISSION';
      case InteriorCreditMediaFileTypeEnum.additional:
        return 'ADDITIONAL';
    }
  }

  String get ext => 'jpg';
}
