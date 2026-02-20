part of 'credit_rework_bloc.dart';

@freezed
class CreditReworkState with _$CreditReworkState {
  const factory CreditReworkState.initial() = Initial;
  const factory CreditReworkState.loading() = Loading;
  const factory CreditReworkState.loaded({
    required CreditReworkModel creditReworkItems,
  }) = Loaded;
  const factory CreditReworkState.error({String? message}) = Error;
}
