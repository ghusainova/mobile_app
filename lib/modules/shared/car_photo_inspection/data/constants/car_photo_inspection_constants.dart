import '../../../../../components/styles/app_assets.dart';
import '../models/photo_inspection_info_item.dart';

List<PhotoInspectionInfoItem> exteriorInspectionItems = [
  const PhotoInspectionInfoItem(
    iconPath: AppAssets.frontHalfLeft,
    title: 'Фото авто спереди слева',
  ),
  const PhotoInspectionInfoItem(
    iconPath: AppAssets.frontHalfRight,
    title: 'Фото авто спереди справа',
  ),
  const PhotoInspectionInfoItem(
    iconPath: AppAssets.backHalfLeft,
    title: 'Фото авто сзади слева',
  ),
  const PhotoInspectionInfoItem(
    iconPath: AppAssets.backHalfRight,
    title: 'Фото авто сзади справа',
  ),
  const PhotoInspectionInfoItem(
    iconPath: AppAssets.engineBay,
    title: 'Фото подкапотного пространства',
  ),
  const PhotoInspectionInfoItem(
    iconPath: AppAssets.trunk,
    title: 'Фото багажника',
  ),
];

List<PhotoInspectionInfoItem> interiorInspectionItems = [
  const PhotoInspectionInfoItem(
    iconPath: AppAssets.frontSeats,
    title: 'Фото переднего ряда сидений',
  ),
  const PhotoInspectionInfoItem(
    iconPath: AppAssets.rearSeats,
    title: 'Фото заднего ряда сидений',
  ),
  const PhotoInspectionInfoItem(
    iconPath: AppAssets.cockpitOverview,
    title: 'Фото салона с заднего ряда сидений',
  ),
  const PhotoInspectionInfoItem(
    iconPath: AppAssets.dashboard,
    title: 'Фото приборной панели',
  ),
  const PhotoInspectionInfoItem(
    iconPath: AppAssets.ac,
    title: 'Фото типа кондиционера',
  ),
  const PhotoInspectionInfoItem(
    iconPath: AppAssets.gearboxShifter,
    title: 'Фото типа КПП',
  ),
];

//Master sto items

List<PhotoInspectionInfoItem> masterStoInspectionItems = [
  const PhotoInspectionInfoItem(
    iconPath: AppAssets.vinCloseView,
    title: 'Фото выбитого VIN-кода',
  ),
  const PhotoInspectionInfoItem(
    iconPath: AppAssets.vinOverview,
    title: 'Обзорное фото выбитого VIN-кода',
  ),
  const PhotoInspectionInfoItem(
    iconPath: AppAssets.videoRecord,
    title: 'Видео выбитого VIN-кода',
    isVideoRecording: true,
  ),
  const PhotoInspectionInfoItem(
    iconPath: AppAssets.vinWindscreen,
    title: 'Фото VIN-кода на лобовом стекле',
  ),
  const PhotoInspectionInfoItem(
    iconPath: AppAssets.vinBadge,
    title: 'Фото бирки с VIN-кодом',
  ),
  const PhotoInspectionInfoItem(
    iconPath: AppAssets.vinSticker,
    title: 'Фото наклейки с VIN-кодом',
  ),
];
