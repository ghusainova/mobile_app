import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../sales_manager/catalog/data/repositories/catalog_repository.dart';

part 'brand_event.dart';
part 'brand_state.dart';
part 'generated/brand_bloc.freezed.dart';

@lazySingleton
class BrandBloc extends Bloc<BrandEvent, BrandState> {
  final CatalogRepository catalogRepository;

  BrandBloc(this.catalogRepository) : super(const _Initial()) {
    on<_Load>(_onLoad);
  }

  Future<void> _onLoad(
    _Load event,
    Emitter<BrandState> emit,
  ) async {
    emit(const _Loading());

    try {
      final brands = await catalogRepository.getBrands();

      if (brands.isEmpty) {
        emit(const _Error(message: 'Не удалось загрузить список марок'));
      } else {
        emit(_Loaded(brands: brands));
      }
    } on DioException catch (e) {
      emit(_Error(message: e.message));
    }
  }
}
