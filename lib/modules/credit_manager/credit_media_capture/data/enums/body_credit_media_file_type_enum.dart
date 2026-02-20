enum BodyCreditMediaFileTypeEnum {
  frontLeft,
  frontRight,
  backLeft,
  backRight,
  hood,
  trunk,
  additional,
}

extension BranchUserQueueTypeExt on BodyCreditMediaFileTypeEnum {
  String get category => 'BODY';

  String get fileType {
    switch (this) {
      case BodyCreditMediaFileTypeEnum.frontLeft:
        return 'FRONT_LEFT';
      case BodyCreditMediaFileTypeEnum.frontRight:
        return 'FRONT_RIGHT';
      case BodyCreditMediaFileTypeEnum.backLeft:
        return 'BACK_LEFT';
      case BodyCreditMediaFileTypeEnum.backRight:
        return 'BACK_RIGHT';
      case BodyCreditMediaFileTypeEnum.hood:
        return 'HOOD';
      case BodyCreditMediaFileTypeEnum.trunk:
        return 'TRUNK';
      case BodyCreditMediaFileTypeEnum.additional:
        return 'ADDITIONAL';
    }
  }

  String get ext => 'jpg';
}
