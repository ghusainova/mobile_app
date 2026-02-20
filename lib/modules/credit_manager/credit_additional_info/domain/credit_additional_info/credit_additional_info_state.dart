part of 'credit_additional_info_bloc.dart';

@freezed
class CreditAdditionalInfoState with _$CreditAdditionalInfoState {
  const factory CreditAdditionalInfoState.loading() = Loading;
  const factory CreditAdditionalInfoState.loaded({
    required CreditAdditionalInfo additionalInfo,
  }) = Loaded;
  const factory CreditAdditionalInfoState.saved() = Saved;
  const factory CreditAdditionalInfoState.error(String? message) = Error;
}
