import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../data/repositories/credit_brand_model_repository.dart';

part 'credit_brand_event.dart';
part 'credit_brand_state.dart';
part 'generated/credit_brand_bloc.freezed.dart';

@lazySingleton
class CreditBrandBloc extends Bloc<CreditBrandEvent, CreditBrandState> {
  final CreditBrandModelRepository repository;

  CreditBrandBloc(this.repository) : super(const _Loading()) {
    on<_Load>(_onLoad);
    on<_Search>(_onSearch);
  }
  static bool _isAppendLoading = false;

  bool get isAppendLoading => _isAppendLoading;

  Future<void> _onLoad(
    _Load event,
    Emitter<CreditBrandState> emit,
  ) async {
    final isAppend = event.offset != null;

    if (isAppend) {
      _isAppendLoading = true;
    } else {
      _isAppendLoading = false;
      emit(const _Loading());
    }

    try {
      final response = await repository.getCreditBrands(event.offset ?? 0);

      final brandList =
          isAppend ? (event.prevContent ?? []) + response : response;
      emit(_Loaded(brands: brandList));

      _isAppendLoading = false;
    } on DioException catch (e) {
      _isAppendLoading = false;

      emit(_Error(message: e.message));
    }
  }

  Future<void> _onSearch(
    _Search event,
    Emitter<CreditBrandState> emit,
  ) async {
    emit(const _Loading());

    try {
      final brands = await repository.searchCreditBrands(event.searchValue);

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
