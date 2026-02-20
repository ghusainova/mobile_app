part of 'interior_bloc.dart';

@freezed
class InteriorState with _$InteriorState {
  const factory InteriorState.loading() = Loading;
  const factory InteriorState.loaded({
    required Map<String, List<ActDetail>> actDetailInfo,
    String? orderId,
  }) = Loaded;
  const factory InteriorState.error(String? errorMessage) = Error;
}
