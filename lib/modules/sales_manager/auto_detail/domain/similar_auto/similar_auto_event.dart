part of 'similar_auto_bloc.dart';

@freezed
class SimilarAutoEvent with _$SimilarAutoEvent {
  const factory SimilarAutoEvent.load({required AutoInfo? autoInfo}) = Load;
}
