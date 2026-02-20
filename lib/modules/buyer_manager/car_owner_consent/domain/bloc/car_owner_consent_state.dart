part of 'car_owner_consent_bloc.dart';

@freezed
class CarOwnerConsentState with _$CarOwnerConsentState {
  const factory CarOwnerConsentState.initial() = _Initial;
  const factory CarOwnerConsentState.sent() = Sent;
  const factory CarOwnerConsentState.error(String? message) = Error;
  const factory CarOwnerConsentState.loading() = Loading;
}
