enum PhotoTypeEnum {
  vehicles,
  diagnostics,
  dashboard,
  steeringWheel,
  driverSeat,
  passengerFrontSeat,
  techReview,
}

extension PhotoTypeEnumExt on PhotoTypeEnum {
  String get label {
    switch (this) {
      case PhotoTypeEnum.vehicles:
        return 'Авто';
      case PhotoTypeEnum.diagnostics:
        return 'Ошибки';
      case PhotoTypeEnum.dashboard:
        return 'Приборная панель';
      case PhotoTypeEnum.steeringWheel:
        return 'Руль';
      case PhotoTypeEnum.driverSeat:
        return 'Водительское сиденье';
      case PhotoTypeEnum.passengerFrontSeat:
        return 'Переднее пассажирское сиденье';
      case PhotoTypeEnum.techReview:
        return 'Техническое состояние';
    }
  }

  String get documentType {
    switch (this) {
      case PhotoTypeEnum.vehicles:
        return 'Объявление';
      case PhotoTypeEnum.diagnostics:
        return 'Компьютерная диагностика';
      case PhotoTypeEnum.techReview:
        return 'Акт диагностики автомобиля';
      default:
        return label;
    }
  }
}
