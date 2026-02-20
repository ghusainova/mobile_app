enum AdditionalInfoParamEnum {
  engineType,
  engine,
  bodyType,
  transmission,
  color,
  drivetrain,
  wheel,
  interiorType,
  airConditioningType,
  boxNumber,
}

extension AdditionalInfoParamExt on AdditionalInfoParamEnum {
  String get label {
    switch (this) {
      case AdditionalInfoParamEnum.engineType:
        return 'Тип топлива';
      case AdditionalInfoParamEnum.engine:
        return 'Объем двигателя';
      case AdditionalInfoParamEnum.bodyType:
        return 'Тип кузова';
      case AdditionalInfoParamEnum.transmission:
        return 'Тип КПП';
      case AdditionalInfoParamEnum.color:
        return 'Цвет';
      case AdditionalInfoParamEnum.drivetrain:
        return 'Тип привода';
      case AdditionalInfoParamEnum.wheel:
        return 'Руль';
      case AdditionalInfoParamEnum.interiorType:
        return 'Отделка салона';
      case AdditionalInfoParamEnum.airConditioningType:
        return 'Тип кондиционера';
      case AdditionalInfoParamEnum.boxNumber:
        return 'Номер бокса';
    }
  }
}
