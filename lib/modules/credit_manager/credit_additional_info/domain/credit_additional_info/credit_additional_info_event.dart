part of 'credit_additional_info_bloc.dart';

@freezed
class CreditAdditionalInfoEvent with _$CreditAdditionalInfoEvent {
  const factory CreditAdditionalInfoEvent.load() = Load;
  const factory CreditAdditionalInfoEvent.changeAdditionalInfo({
    required AdditionalInfoParamEnum param,
    required String value,
  }) = ChangeAdditionalInfo;
  const factory CreditAdditionalInfoEvent.save({bool? setStage}) = Save;
}
