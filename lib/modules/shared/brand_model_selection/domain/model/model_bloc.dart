import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../sales_manager/catalog/data/repositories/catalog_repository.dart';

part 'model_event.dart';
part 'model_state.dart';
part 'generated/model_bloc.freezed.dart';

@lazySingleton
class ModelBloc extends Bloc<ModelEvent, ModelState> {
  final CatalogRepository catalogRepository;

  ModelBloc(this.catalogRepository) : super(const _Initial()) {
    on<_Load>(_onLoad);
  }

  Future<void> _onLoad(
    _Load event,
    Emitter<ModelState> emit,
  ) async {
    emit(const _Loading());

    try {
      final models = await catalogRepository.getModels(event.brand);

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
