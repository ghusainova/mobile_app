import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../queue/domain/buyout/buyout_bloc.dart';
import '../../../shared/_data/repositories/buyout_shared_repository.dart';

part 'car_owner_consent_event.dart';
part 'car_owner_consent_state.dart';
part 'generated/car_owner_consent_bloc.freezed.dart';

@lazySingleton
class CarOwnerConsentBloc
    extends Bloc<CarOwnerConsentEvent, CarOwnerConsentState> {
  final BuyoutSharedRepository repository;
  final BuyoutBloc buyoutBloc;

  CarOwnerConsentBloc(this.repository, this.buyoutBloc)
      : super(const _Initial()) {
    on<GetCarOwnerConsent>(_getCarOwnerConsent);
  }

  Future<void> _getCarOwnerConsent(
      event, Emitter<CarOwnerConsentState> emit,) async {
    if (buyoutBloc.autoInfo == null) {
      return;
    }

    try {
      await repository.getCarOwnerConsent(
          event.clientIin, buyoutBloc.autoInfo!.integrationId,);
      emit(const CarOwnerConsentState.sent());
    } on DioException catch (e) {
      emit(Error(e.message));
    }
  }
}
