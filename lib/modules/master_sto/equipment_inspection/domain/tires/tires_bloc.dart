import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../data/repositories/tires_repository.dart';

part 'tires_event.dart';
part 'tires_state.dart';
part 'generated/tires_bloc.freezed.dart';

@lazySingleton
class TiresBloc extends Bloc<TiresEvent, TiresState> {
  final TiresRepository tiresRepository;

  TiresBloc(this.tiresRepository) : super(const Loading()) {
    on<GetTiresBrands>(_getTiresBrands);
  }

  Future<void> _getTiresBrands(
    GetTiresBrands event,
    Emitter<TiresState> emit,
  ) async {
    try {
      final response = await tiresRepository.getTiresBrands()
        ..sort();

      if (response.isNotEmpty) {
        emit(Loaded(response));
      } else {
        emit(const NoData());
      }
    } on DioException catch (e) {
      emit(NoData(error: e.message));
    }
  }
}
