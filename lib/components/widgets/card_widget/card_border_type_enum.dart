import 'package:flutter/material.dart';

enum CardBorderTypeEnum {
  all,
  onlyTop,
  onlyBottom,
  none,
}

extension CardBorderTypeEnumExt on CardBorderTypeEnum {
  BorderRadius get value {
    switch (this) {
      case CardBorderTypeEnum.all:
        return BorderRadius.circular(16);
      case CardBorderTypeEnum.onlyTop:
        return const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        );
      case CardBorderTypeEnum.onlyBottom:
        return const BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        );
      case CardBorderTypeEnum.none:
        return BorderRadius.zero;
    }
  }
}
