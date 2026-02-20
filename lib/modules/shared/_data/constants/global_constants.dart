class Constants {
  static const String devEnvKey = 'DEV_ENV_KEY';
  static const String prodEnvKey = 'PROD_ENV_KEY';

  static const Duration dioTimeout = Duration(seconds: 60);
  static const int dioRefreshTokenCount = 3;

  static const String brand = 'Марка';
  static const String model = 'Модель авто';
  static const String brandAuto = 'Марка авто';
  static const String modelAuto = 'Модель авто';
  static const String brandModel = 'Марка/Модель';
  static const String year = 'Год выпуска';
  static const String color = 'Цвет';
  static const String price = 'Цена';
  static const String mileage = 'Пробег';
  static const String stateNumber = 'Госномер';
  static const String engineVolume = 'Объем двигателя';
  static const String engineType = 'Тип топлива';
  static const String transmission = 'Коробка передач';
  static const String drivetrain = 'Тип привода';
  static const String steeringWheel = 'Руль';

  static const String vin = 'VIN-код';
  static const String bodyNumber = 'Номер кузова';

  static const List<String> drivetrainTypes = [
    'передний привод',
    'задний привод',
    'полный привод',
  ];

  static const List<String> bodyTypes = [
    'СЕДАН',
    'КРОССОВЕР',
    'ВНЕДОРОЖНИК',
    'ХЭТЧБЕК',
    'ЛИФТБЕК',
    'УНИВЕРСАЛ',
  ];

  static const List<String> transmissionTypes = [
    'МЕХАНИКА',
    'АВТОМАТ',
    'ТИПТРОНИК',
    'РОБОТ',
    'ВАРИАТОР',
  ];

  static const List<String> engineVolumesTypes = [
    '1',
    '1.2',
    '1.3',
    '1.4',
    '1.5',
    '1.6',
    '1.7',
    '1.8',
    '2',
    '2.4',
    '2.5',
    '2.7',
    '3',
    '3.5',
    '3.8',
    '4',
    '4.7',
  ];
  static const List<String> colorTypes = [
    'Бронза',
    'Вишня',
    'Хамелеон',
    'Бежевый',
    'Белый',
    'Бирюзовый',
    'Бордовый',
    'Голубой',
    'Жёлтый',
    'Зеленый',
    'Золотистый',
    'Коричневый',
    'Красный',
    'Оранжевый',
    'Розовый',
    'Серебристый',
    'Серый',
    'Синий',
    'Сиреневый',
    'Фиолетовый',
    'Черный',
  ];

  static const List<int> creditTerms = [12, 24, 36, 48, 60];

  ///DEFECTS
  static const String roof = 'Крыша';
  static const String hood = 'Капот';
  static const String windshield = 'Лобовое стекло';
  static const String frontBumper = 'Передний бампер';
  static const String frontLights = 'Передние световые приборы';
  static const String leftFrontFender = 'Левое переднее крыло';
  static const String leftFrontDoor = 'Левая передняя дверь';
  static const String racksSillsLeftFrontDoor =
      'Стойки и порожки левой передней двери';
  static const String leftBackDoor = 'Левая задняя дверь';
  static const String racksSillsLeftBackDoor =
      'Стойки и порожки левой задней двери';
  static const String leftBackFender = 'Левое заднее крыло';
  static const String backGlass = 'Заднее стекло';
  static const String trunk = 'Багажник';
  static const String backBumper = 'Задний бампер';
  static const String backLights = 'Задние световые приборы';
  static const String rightBackFender = 'Правое заднее крыло';
  static const String rightBackDoor = 'Правая задняя дверь';
  static const String racksSillsRightBackDoor =
      'Стойки и порожки правой задней двери';
  static const String rightFrontDoor = 'Правая передняя дверь';
  static const String racksSillsRightFrontDoor =
      'Стойки и порожки правой передней двери';
  static const String rightFrontFender = 'Правое переднее крыло';

  static const String leftFrontLights = 'Передняя оптика слева';
  static const String leftBackLights = 'Задняя оптика слева';
  static const String rightFrontLights = 'Передняя оптика справа';
  static const String rightBackLights = 'Задняя оптика справа';

  static const List<String> salesInspectionDefects = ['Разбито', 'Трещина'];
  static const List<String> buyerInspectionDefects = [
    'Скол',
    'Царапина',
    'Трещина',
    'Вмятина',
    'Замена детали',
    'Пленка',
    'Разбито',
  ];
}
