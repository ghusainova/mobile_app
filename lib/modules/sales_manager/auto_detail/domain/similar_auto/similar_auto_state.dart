part of 'similar_auto_bloc.dart';

@freezed
class SimilarAutoState with _$SimilarAutoState {
  const factory SimilarAutoState.loading() = Loading;
  const factory SimilarAutoState.hasContent({
    List<AutoInfo>? similarAutoCatalog,
  }) = HasContent;
  const factory SimilarAutoState.error(String? message) = Error;
}
