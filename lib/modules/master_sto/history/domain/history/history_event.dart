part of 'history_bloc.dart';

@freezed
class HistoryEvent with _$HistoryEvent {
  const factory HistoryEvent.load() = Load;
  const factory HistoryEvent.cancelCase() = CancelCase;
  const factory HistoryEvent.finish({String? comment}) = Finish;
}
