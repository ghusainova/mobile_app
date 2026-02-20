enum VinCreditMediaFileTypeEnum {
  video,
  photo,
}

extension BranchUserQueueTypeExt on VinCreditMediaFileTypeEnum {
  String get category => 'VIN';

  String get fileType {
    switch (this) {
      case VinCreditMediaFileTypeEnum.photo:
        return 'VIN';
      case VinCreditMediaFileTypeEnum.video:
        return 'VIN_VIDEO';
    }
  }

  String get ext {
    switch (this) {
      case VinCreditMediaFileTypeEnum.video:
        return 'mp4';
      case VinCreditMediaFileTypeEnum.photo:
        return 'jpg';
    }
  }
}
