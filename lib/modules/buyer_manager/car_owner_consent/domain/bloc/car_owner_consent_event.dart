part of 'car_owner_consent_bloc.dart';

@freezed
class CarOwnerConsentEvent with _$CarOwnerConsentEvent {
  const factory CarOwnerConsentEvent.getCarOwnerConsent(String clientIin) =
      GetCarOwnerConsent;
}
