part of 'additional_info_bloc.dart';

@freezed
class AdditionalInfoState with _$AdditionalInfoState {
  const factory AdditionalInfoState.loading() = Loading;
  const factory AdditionalInfoState.loaded({
    required AdditionalInfo additionalInfo,
    List<String>? engineVolumes,
  }) = Loaded;
  const factory AdditionalInfoState.saved() = Saved;
  const factory AdditionalInfoState.error(String? message) = Error;
}
