//CarPhotoInspection inspection args

import '../models/car_photo_inspection_args.dart';
import 'car_photo_inspection_constants.dart';

final exteriorInspectionArgs = CarPhotoInspectionArgs(
  title: 'Фото кузова',
  subtitle: 'Сделайте фото кузова внутри бокса',
  btnTitle: 'Продолжить',
  inspectionInfoItems: exteriorInspectionItems,
);

final interiorInspectionArgs = CarPhotoInspectionArgs(
  title: 'Фото салона',
  subtitle: 'Сделайте фото салона',
  btnTitle: 'Завершить фотографирование',
  inspectionInfoItems: interiorInspectionItems,
);

//Master sto inspection args

final masterStoInspectionArgs = CarPhotoInspectionArgs(
  title: 'Фото и видео VIN-кода',
  subtitle: 'Добавьте фото и видео VIN-кода',
  btnTitle: 'Продолжить',
  inspectionInfoItems: masterStoInspectionItems,
);
