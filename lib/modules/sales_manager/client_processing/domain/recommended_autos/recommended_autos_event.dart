part of 'recommended_autos_bloc.dart';

@freezed
class RecommendedAutosEvent with _$RecommendedAutosEvent {
  const factory RecommendedAutosEvent.getRecommendedAutos({
    AutoInfo? autoInfo,
    String? iin,
  }) = GetRecommendedAutos;
}
