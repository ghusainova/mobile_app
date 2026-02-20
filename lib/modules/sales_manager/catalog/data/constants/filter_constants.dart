import '../models/chip_form_info.dart';
import '../models/filter_input_info.dart';
import '../../../../shared/_data/constants/global_constants.dart';

FilterInputInfo priceInfo = FilterInputInfo(
  label: Constants.price,
  fields: [
    FilterInputItem(
      fieldName: 'lowerPrice',
      hintText: 'От',
      useNumericKeyboard: true,
      usePriceFormatter: true,
    ),
    FilterInputItem(
      fieldName: 'upperPrice',
      hintText: 'До',
      useNumericKeyboard: true,
      usePriceFormatter: true,
    ),
  ],
);
FilterInputInfo yearInfo = FilterInputInfo(
  label: 'Год выпуска',
  fields: [
    FilterInputItem(
      fieldName: 'lowerYear',
      hintText: 'От',
      useNumericKeyboard: true,
    ),
    FilterInputItem(
      fieldName: 'upperYear',
      hintText: 'До',
      useNumericKeyboard: true,
    ),
  ],
);
FilterInputInfo vinInfo = FilterInputInfo(
  label: 'VIN-код',
  fields: [
    FilterInputItem(
      fieldName: 'vin',
      hintText: 'VIN-код',
    ),
  ],
);
FilterInputInfo bodyNumberInfo = FilterInputInfo(
  label: 'Номер кузова',
  fields: [
    FilterInputItem(
      fieldName: 'bodyNumber',
      hintText: 'Номер кузова',
    ),
  ],
);
FilterInputInfo parkingInfo = FilterInputInfo(
  label: 'Ряд и место',
  fields: [
    FilterInputItem(
      fieldName: 'parkingRow',
      hintText: 'Ряд',
    ),
    FilterInputItem(
      fieldName: 'parkingSlot',
      hintText: 'Место',
    ),
  ],
);
FilterInputInfo mileageInfo = FilterInputInfo(
  label: 'Пробег, км',
  fields: [
    FilterInputItem(
      fieldName: 'mileage',
      hintText: 'До',
      useNumericKeyboard: true,
      usePriceFormatter: true,
    ),
  ],
);

ChipFormInfo transmissionInfo = ChipFormInfo(
    label: 'Коробка передач',
    field: 'transmission',
    options: Constants.transmissionTypes,
    chosenOption: '',);

ChipFormInfo bodyTypeInfo = ChipFormInfo(
    label: 'Кузов',
    field: 'bodyType',
    options: Constants.bodyTypes,
    chosenOption: '',);

ChipFormInfo drivetrainInfo = ChipFormInfo(
    label: 'Привод',
    field: 'drivetrain',
    options: Constants.drivetrainTypes,
    chosenOption: '',);

List filters = [
  priceInfo,
  yearInfo,
  vinInfo,
  bodyNumberInfo,
  parkingInfo,
  transmissionInfo,
  bodyTypeInfo,
  drivetrainInfo,
  mileageInfo,
];
