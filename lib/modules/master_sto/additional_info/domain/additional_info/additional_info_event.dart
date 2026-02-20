part of 'additional_info_bloc.dart';

@freezed
class AdditionalInfoEvent with _$AdditionalInfoEvent {
  const factory AdditionalInfoEvent.load() = Load;
  const factory AdditionalInfoEvent.changeAdditionalInfo({
    required AdditionalInfoParamEnum param,
    required String value,
  }) = ChangeAdditionalInfo;
  const factory AdditionalInfoEvent.save({bool? setStage}) = Save;
}
