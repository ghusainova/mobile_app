part of 'defects_bloc.dart';

@freezed
class DefectsState with _$DefectsState {
  const factory DefectsState.loading() = Loading;
  const factory DefectsState.loaded({required DefectModel defectModel}) =
      Loaded;
  const factory DefectsState.error(String? message) = Error;
  const factory DefectsState.saved() = Saved;
}
