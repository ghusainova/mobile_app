part of 'defects_map_bloc.dart';

@freezed
class DefectsMapState with _$DefectsMapState {
  const factory DefectsMapState.loading() = Loading;
  const factory DefectsMapState.loaded({
    required List<DefectModel> defectList,
  }) = Loaded;
  const factory DefectsMapState.error(String? message) = Error;
}
