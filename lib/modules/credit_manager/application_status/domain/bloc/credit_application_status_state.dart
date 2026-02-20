part of 'credit_application_status_bloc.dart';

@freezed
class CreditApplicationStatusState with _$CreditApplicationStatusState {
  const factory CreditApplicationStatusState.loading() = Loading;
  const factory CreditApplicationStatusState.loaded(
    List<CreditStatusItem> statusList,
  ) = Loaded;
  const factory CreditApplicationStatusState.error({String? message}) = Error;
  const factory CreditApplicationStatusState.noContent({
    String? rejectionMessage,
  }) = NoContent;
}
