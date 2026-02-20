import '../../../credit_media_capture/domain/bloc/credit_media_capture_bloc.dart';

void registerCreditManagerInjection() {
  CreditMediaCaptureBloc().registerInjection();
}

void unregisterCreditManagerInjection() {
  CreditMediaCaptureBloc().unregisterInjection();
}
