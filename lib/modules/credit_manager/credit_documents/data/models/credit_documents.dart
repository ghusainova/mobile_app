import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/credit_documents.freezed.dart';
part 'generated/credit_documents.g.dart';

@freezed
class CreditDocuments with _$CreditDocuments {
  const factory CreditDocuments({
    @Default([]) List<String> documentBase64,
  }) = _CreditDocument;

  factory CreditDocuments.fromJson(Map<String, dynamic> json) =>
      _$CreditDocumentsFromJson(json);
}
