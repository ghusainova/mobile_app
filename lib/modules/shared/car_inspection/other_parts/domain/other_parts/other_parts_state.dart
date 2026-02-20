part of 'other_parts_bloc.dart';

@freezed
class OtherPartsState with _$OtherPartsState {
  const factory OtherPartsState.loading() = Loading;
  const factory OtherPartsState.loaded({
    required Map<String, List<ActDetail>> otherPartsInfo,
  }) = Loaded;
  const factory OtherPartsState.error(String? errorMessage) = Error;
}
