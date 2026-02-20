enum RegcertCreditMediaFileTypeEnum {
  front,
  back,
}

extension BranchUserQueueTypeExt on RegcertCreditMediaFileTypeEnum {
  String get category => 'REGCERT';

  String get fileType {
    switch (this) {
      case RegcertCreditMediaFileTypeEnum.front:
        return 'FRONT';
      case RegcertCreditMediaFileTypeEnum.back:
        return 'BACK';
    }
  }

  String get ext => 'jpg';
}
