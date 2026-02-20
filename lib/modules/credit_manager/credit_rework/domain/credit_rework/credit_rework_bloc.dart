import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../credit_application/domain/credit_application/credit_application_bloc.dart';
import '../../data/models/credit_rework_model.dart';
import '../../data/repositories/credit_rework_repository.dart';

part 'credit_rework_event.dart';
part 'credit_rework_state.dart';
part 'generated/credit_rework_bloc.freezed.dart';

@lazySingleton
class CreditReworkBloc extends Bloc<CreditReworkEvent, CreditReworkState> {
  final CreditReworkRepository repository;
  final CreditApplicationBloc aclBloc;

  CreditReworkBloc(
    this.repository,
    this.aclBloc,
  ) : super(const Loading()) {
    on<Load>(_onLoad);
    on<Reset>(_onReset);
  }

  Future<void> _onLoad(Load event, Emitter<CreditReworkState> emit) async {
    emit(const Loading());
    if (aclBloc.orderId == null) {
      emit(const Error(message: 'Order Id not specified'));
      return;
    }

    try {
      final response = await repository.getCreditReworkItems(aclBloc.orderId!);
      emit(Loaded(creditReworkItems: response));
    } on DioException catch (e) {
      emit(Error(message: e.message));
    }
  }

  void _onReset(Reset event, Emitter<CreditReworkState> emit) {
    emit(const Initial());
  }

  bool isReworkImage(String source) {
    final files =
        state is Loaded ? (state as Loaded).creditReworkItems.files : [];

    if (files.isEmpty) return false;

    final result = files.any((l) => source.contains(l));

    return result;
  }
}
