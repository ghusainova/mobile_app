part of 'scan_cases_bloc.dart';

@freezed
class ScanCasesState with _$ScanCasesState {
  const factory ScanCasesState.loading() = Loading;
  const factory ScanCasesState.loaded({required List<ScanCase> cases}) = Loaded;
  const factory ScanCasesState.gotInWork({bool? isCaseInProgress}) = GotInWork;
  const factory ScanCasesState.error(String? message) = Error;
  const factory ScanCasesState.noContent() = NoContent;
}
