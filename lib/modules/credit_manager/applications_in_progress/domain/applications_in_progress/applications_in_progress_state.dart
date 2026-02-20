part of 'applications_in_progress_bloc.dart';

@freezed
class ApplicationsInProgressState with _$ApplicationsInProgressState {
  const factory ApplicationsInProgressState.loading() = Loading;
  const factory ApplicationsInProgressState.loaded({
    required List<CreditApplication> applicationsInProgress,
  }) = Loaded;
  const factory ApplicationsInProgressState.error(String? message) = Error;
  const factory ApplicationsInProgressState.noContent() = NoContent;
}
