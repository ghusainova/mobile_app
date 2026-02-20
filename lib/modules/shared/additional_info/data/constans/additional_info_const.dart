import '../../../_data/constants/global_constants.dart';
import '../enums/additional_info_param_enum.dart';

class AdditionalInfoConstants {
  static const List<String> engineTypes = [
    'БЕНЗИН',
    'ДИЗЕЛЬ',
    'ГАЗ',
    'ГИБРИД',
    'ЭЛЕКТРИЧЕСТВО',
  ];
  static const List<String> interiorTypes = ['Велюр', 'Кожа/Комбинированный'];
  static const List<String> steeringWheelTypes = ['Слева', 'Справа'];
  static const List<String> airConditioningTypes = [
    'Кондиционер',
    'Климат-контроль',
    'Отсутствует',
  ];
  static final List<String> serviceBoxNums =
      List<String>.generate(5, (index) => '${index + 1}');
  static const List<String> colorTypes = [
    'КОМБИНИРОВАННЫЙ',
    'РОЗОВЫЙ',
    'КОРИЧНЕВЫЙ',
    'СЕРЫЙ',
    'БЕЛЫЙ',
    'ФИОЛЕТОВЫЙ',
    'СИНИЙ',
    'ГОЛУБОЙ',
    'ЗЕЛЕНЫЙ',
    'ЖЕЛТЫЙ',
    'ОРАНЖЕВЫЙ',
    'КРАСНЫЙ',
    'ЧЕРНЫЙ',
  ];

  static List<FieldConfig> masterParamList = [
    FieldConfig(
      param: AdditionalInfoParamEnum.engineType,
      lov: engineTypes,
    ),
    FieldConfig(
      param: AdditionalInfoParamEnum.engine,
      lov: null,
    ),
    FieldConfig(
      param: AdditionalInfoParamEnum.bodyType,
      lov: Constants.bodyTypes,
    ),
    FieldConfig(
      param: AdditionalInfoParamEnum.transmission,
      lov: Constants.transmissionTypes,
    ),
    FieldConfig(
      param: AdditionalInfoParamEnum.drivetrain,
      lov: Constants.drivetrainTypes,
    ),
    FieldConfig(
      param: AdditionalInfoParamEnum.interiorType,
      lov: interiorTypes,
    ),
    FieldConfig(
      param: AdditionalInfoParamEnum.airConditioningType,
      lov: airConditioningTypes,
    ),
  ];
  static List<FieldConfig> creditParamList = [
    FieldConfig(
      param: AdditionalInfoParamEnum.engineType,
      lov: engineTypes,
    ),
    FieldConfig(
      param: AdditionalInfoParamEnum.engine,
    ),
    FieldConfig(
      param: AdditionalInfoParamEnum.bodyType,
      lov: Constants.bodyTypes,
    ),
    FieldConfig(
      param: AdditionalInfoParamEnum.transmission,
      lov: Constants.transmissionTypes,
    ),
    FieldConfig(
      param: AdditionalInfoParamEnum.color,
      lov: colorTypes,
    ),
    FieldConfig(
      param: AdditionalInfoParamEnum.drivetrain,
      lov: Constants.drivetrainTypes,
    ),
    FieldConfig(
      param: AdditionalInfoParamEnum.wheel,
      lov: steeringWheelTypes,
    ),
    FieldConfig(
      param: AdditionalInfoParamEnum.interiorType,
      lov: interiorTypes,
    ),
    FieldConfig(
      param: AdditionalInfoParamEnum.airConditioningType,
      lov: airConditioningTypes,
    ),
    FieldConfig(
      param: AdditionalInfoParamEnum.boxNumber,
      lov: serviceBoxNums,
    ),
  ];
}

class FieldConfig {
  final AdditionalInfoParamEnum param;
  final List<String>? lov;

  FieldConfig({
    required this.param,
    this.lov,
  });
}
