part of 'scan_cases_bloc.dart';

@freezed
class ScanCasesEvent with _$ScanCasesEvent {
  const factory ScanCasesEvent.load() = Load;
  const factory ScanCasesEvent.setCaseInWork({
    required ScanCase scanCase,
    bool? isCaseInProgress,
  }) = SetCaseInWork;
}
