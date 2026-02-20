import '../../../../../components/styles/app_assets.dart';
import '../models/credit_photo_inspection_info_item.dart';

List<CreditPhotoInspectionInfoItem> creditExteriorInspectionItems = [
  const CreditPhotoInspectionInfoItem(
    imagePath: AppAssets.frontHalfLeft,
    title: 'Фото авто спереди слева',
    fileType: 'FRONT_LEFT',
    category: 'BODY',
  ),
  const CreditPhotoInspectionInfoItem(
    imagePath: AppAssets.frontHalfRight,
    title: 'Фото авто спереди справа',
    fileType: 'FRONT_RIGHT',
    category: 'BODY',
  ),
  const CreditPhotoInspectionInfoItem(
    imagePath: AppAssets.backHalfLeft,
    title: 'Фото авто сзади слева',
    fileType: 'BACK_LEFT',
    category: 'BODY',
  ),
  const CreditPhotoInspectionInfoItem(
    imagePath: AppAssets.backHalfRight,
    title: 'Фото авто сзади справа',
    fileType: 'BACK_RIGHT',
    category: 'BODY',
  ),
  const CreditPhotoInspectionInfoItem(
    imagePath: AppAssets.engineBay,
    title: 'Фото подкапотного пространства',
    fileType: 'HOOD',
    category: 'BODY',
  ),
  const CreditPhotoInspectionInfoItem(
    imagePath: AppAssets.trunk,
    title: 'Фото багажника',
    fileType: 'TRUNK',
    category: 'BODY',
  ),
];

List<CreditPhotoInspectionInfoItem> creditInteriorInspectionItems = [
  const CreditPhotoInspectionInfoItem(
    imagePath: AppAssets.frontSeats,
    title: 'Фото переднего ряда сидений',
    fileType: 'FRONT_ROW',
    category: 'INTERIOR',
  ),
  const CreditPhotoInspectionInfoItem(
    imagePath: AppAssets.rearSeats,
    title: 'Фото заднего ряда сидений',
    fileType: 'BACKSEAT',
    category: 'INTERIOR',
  ),
  const CreditPhotoInspectionInfoItem(
    imagePath: AppAssets.cockpitOverview,
    title: 'Фото салона с заднего ряда сидений',
    fileType: 'FROM_BACKSEAT',
    category: 'INTERIOR',
  ),
  const CreditPhotoInspectionInfoItem(
    imagePath: AppAssets.dashboard,
    title: 'Фото приборной панели',
    fileType: 'DASHBOARD',
    category: 'INTERIOR',
  ),
  const CreditPhotoInspectionInfoItem(
    imagePath: AppAssets.ac,
    title: 'Фото типа кондиционера',
    fileType: 'CONDITIONER',
    category: 'INTERIOR',
  ),
  const CreditPhotoInspectionInfoItem(
    imagePath: AppAssets.gearboxShifter,
    title: 'Фото типа КПП',
    fileType: 'TRANSMISSION',
    category: 'INTERIOR',
  ),
];

List<CreditPhotoInspectionInfoItem> creditRegCertInspectionItems = [
  const CreditPhotoInspectionInfoItem(
    imagePath: AppAssets.regcertFront,
    title: 'Фото лицевой стороны',
    fileType: 'FRONT',
    category: 'REGCERT',
  ),
  const CreditPhotoInspectionInfoItem(
    imagePath: AppAssets.regcertBack,
    title: 'Фото обратной стороны',
    fileType: 'BACK',
    category: 'REGCERT',
  ),
];
