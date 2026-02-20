part of 'auto_detail_bloc.dart';

@freezed
class AutoDetailState with _$AutoDetailState {
  const factory AutoDetailState.loading() = Loading;
  const factory AutoDetailState.loaded({required AutoInfo autoInfo}) = Loaded;
  const factory AutoDetailState.error(String? message) = Error;
  const factory AutoDetailState.noContent() = NoContent;
}
