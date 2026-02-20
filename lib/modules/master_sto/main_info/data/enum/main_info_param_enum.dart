enum MainInfoParamEnum {
  brand,
  model,
  year,
  stateNumber,
  vin,
  bodyNumber,
  mileage,
}

extension MainInfoParamExt on MainInfoParamEnum {
  String get label {
    switch (this) {
      case MainInfoParamEnum.brand:
        return 'Марка';
      case MainInfoParamEnum.model:
        return 'Модель';
      case MainInfoParamEnum.year:
        return 'Год выпуска';
      case MainInfoParamEnum.stateNumber:
        return 'Госномер';
      case MainInfoParamEnum.vin:
        return 'VIN-код';
      case MainInfoParamEnum.bodyNumber:
        return 'Номер кузова, если отличается от VIN';
      case MainInfoParamEnum.mileage:
        return 'Пробег, км';
    }
  }
}
