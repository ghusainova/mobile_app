part of 'main_info_bloc.dart';

@freezed
class MainInfoEvent with _$MainInfoEvent {
  const factory MainInfoEvent.load() = Load;
  const factory MainInfoEvent.changeMainInfo({
    required MainInfoParamEnum key,
    required String value,
  }) = ChangeMainInfo;
  const factory MainInfoEvent.save({bool? setStage}) = Save;
}
