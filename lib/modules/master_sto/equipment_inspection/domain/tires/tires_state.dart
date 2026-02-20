part of 'tires_bloc.dart';

@freezed
class TiresState with _$TiresState {
  const factory TiresState.loading() = Loading;
  const factory TiresState.loaded(List<String> tireBrands) = Loaded;
  const factory TiresState.noData({String? error}) = NoData;
}
