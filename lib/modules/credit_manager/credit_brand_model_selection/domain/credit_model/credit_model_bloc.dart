import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../data/repositories/credit_brand_model_repository.dart';

part 'credit_model_event.dart';
part 'credit_model_state.dart';
part 'generated/credit_model_bloc.freezed.dart';

@lazySingleton
class CreditModelBloc extends Bloc<CreditModelEvent, CreditModelState> {
  final CreditBrandModelRepository repository;

  CreditModelBloc(this.repository) : super(const _Initial()) {
    on<_Load>(_onLoad);
  }

  Future<void> _onLoad(
    _Load event,
    Emitter<CreditModelState> emit,
  ) async {
    emit(const _Loading());

    try {
      final models = await repository.getCreditModels(event.brand);

      if (models.isEmpty) {
        emit(const _Error(message: 'Не удалось загрузить список марок'));
      } else {
        emit(_Loaded(models: models));
      }
    } on DioException catch (e) {
      emit(_Error(message: e.message));
    }
  }
}
