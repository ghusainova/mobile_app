import '../../../shared/media_capture_vin/domain/media_capture_vin/media_capture_vin_bloc.dart';
import '../../additional_info/domain/additional_info/additional_info_bloc.dart';
import '../../defect_inspection/defect_pages/domain/defects/defects_bloc.dart';
import '../../defect_inspection/defect_map/domain/defects_map/defects_map_bloc.dart';
import '../../equipment_inspection/domain/equipment_inspection/equipment_inspection_bloc.dart';
import '../../main_info/domain/main_info/main_info_bloc.dart';

void registerMasterStoInjection() {
  MainInfoBloc().registerInjection();
  AdditionalInfoBloc().registerInjection();
  MediaCaptureVinBloc().registerInjection();
  DefectsBloc().registerInjection();
  DefectsMapBloc().registerInjection();
  EquipmentInspectionBloc().registerInjection();
}

void unregisterMasterStoInjection() {
  MainInfoBloc().unregisterInjection();
  AdditionalInfoBloc().unregisterInjection();
  MediaCaptureVinBloc().unregisterInjection();
  DefectsBloc().unregisterInjection();
  DefectsMapBloc().unregisterInjection();
  EquipmentInspectionBloc().unregisterInjection();
}
