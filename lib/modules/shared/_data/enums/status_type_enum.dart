import 'package:flutter/material.dart';

import '../../../../components/styles/app_colors.dart';

enum StatusTypeEnum { success, warning, info, error }

extension StatusTypeEnumExt on StatusTypeEnum {
  Color get bgColor {
    switch (this) {
      case StatusTypeEnum.success:
        return AppColors.successBack;
      case StatusTypeEnum.warning:
        return AppColors.yellowLight;
      case StatusTypeEnum.info:
        return AppColors.neutralBlackAlt;
      case StatusTypeEnum.error:
        return AppColors.blackBg;
    }
  }

  Color get iconColor {
    switch (this) {
      case StatusTypeEnum.success:
        return AppColors.success;
      case StatusTypeEnum.warning:
        return AppColors.yellowDark;
      case StatusTypeEnum.info:
        return AppColors.buttonBlue;
      case StatusTypeEnum.error:
        return Colors.white;
    }
  }

  Color get textColor {
    switch (this) {
      case StatusTypeEnum.error:
        return Colors.white;
      default:
        return Colors.black;
    }
  }

  IconData get icon {
    switch (this) {
      case StatusTypeEnum.success:
        return Icons.check_circle;
      case StatusTypeEnum.warning:
        return Icons.warning_rounded;
      case StatusTypeEnum.info:
        return Icons.info;
      case StatusTypeEnum.error:
        return Icons.warning_rounded;
    }
  }

  String get name {
    switch (this) {
      case StatusTypeEnum.success:
        return 'SUCCESS';
      case StatusTypeEnum.warning:
        return 'WARNING';
      case StatusTypeEnum.info:
        return 'INFO';
      case StatusTypeEnum.error:
        return 'ERROR';
    }
  }
}

StatusTypeEnum? getStatusEnumFromType(String name) {
  if (name.isEmpty) {
    return null;
  }
  return StatusTypeEnum.values.firstWhere((bodyPart) => bodyPart.name == name);
}
