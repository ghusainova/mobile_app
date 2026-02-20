part of 'defects_bloc.dart';

@freezed
class DefectsEvent with _$DefectsEvent {
  const factory DefectsEvent.load({
    required CarBodyPart bodyPart,
  }) = Load;
  const factory DefectsEvent.setDefect(
    DefectModel defect,
  ) = SetDefect;
  const factory DefectsEvent.updateDefectStatus(
    List<Defect> defects,
  ) = UpdateDefectStatus;
  const factory DefectsEvent.resetDefectStatus() = ResetDefectStatus;

  const factory DefectsEvent.save({
    bool? setStage,
  }) = Save;
}
