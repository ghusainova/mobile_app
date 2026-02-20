part of 'model_bloc.dart';

@freezed
class ModelEvent with _$ModelEvent {
  const factory ModelEvent.started() = _Started;
  const factory ModelEvent.load(String brand) = _Load;
}
