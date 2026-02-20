part of 'credit_model_bloc.dart';

@freezed
class CreditModelState with _$CreditModelState {
  const factory CreditModelState.initial() = _Initial;
  const factory CreditModelState.loading() = _Loading;
  const factory CreditModelState.loaded({required List<String> models}) =
      _Loaded;
  const factory CreditModelState.error({String? message}) = _Error;
}
