enum MediaTypeEnum {
  photo,
  video,
}

extension BranchUserQueueTypeExt on MediaTypeEnum {
  String get code {
    switch (this) {
      case MediaTypeEnum.photo:
        return 'VIN';
      case MediaTypeEnum.video:
        return 'Видео Vin кода';
    }
  }

  String get ext {
    switch (this) {
      case MediaTypeEnum.video:
        return 'mp4';
      default:
        return 'jpg';
    }
  }
}
