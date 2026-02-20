part of 'history_bloc.dart';

@freezed
class HistoryState with _$HistoryState {
  const factory HistoryState.loading() = Loading;
  const factory HistoryState.loaded({required History history}) = Loaded;
  const factory HistoryState.error(String? message) = Error;
  const factory HistoryState.finished() = Finished;
  const factory HistoryState.canceled() = Canceled;
}
