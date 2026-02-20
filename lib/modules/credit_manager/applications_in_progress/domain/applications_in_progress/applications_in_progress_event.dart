part of 'applications_in_progress_bloc.dart';

@freezed
class ApplicationsInProgressEvent with _$ApplicationsInProgressEvent {
  const factory ApplicationsInProgressEvent.load() = Load;
  const factory ApplicationsInProgressEvent.search(String searchParam) = Search;
}
