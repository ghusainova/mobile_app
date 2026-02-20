part of 'credit_documents_bloc.dart';

@freezed
class CreditDocumentsState with _$CreditDocumentsState {
  const factory CreditDocumentsState.loading() = Loading;
  const factory CreditDocumentsState.loaded(CreditDocuments creditDocs) =
      Loaded;
  const factory CreditDocumentsState.error(String? message) = Error;
}
