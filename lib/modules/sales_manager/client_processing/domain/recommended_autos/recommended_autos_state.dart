part of 'recommended_autos_bloc.dart';

@freezed
class RecommendedAutosState with _$RecommendedAutosState {
  const factory RecommendedAutosState.loading() = _Loading;
  const factory RecommendedAutosState.hasContent(
    List<AutoInfo> recommendedList,
  ) = _HasContent;
  const factory RecommendedAutosState.error(String? message) = _Error;
  const factory RecommendedAutosState.noContent() = _NoContent;
}
