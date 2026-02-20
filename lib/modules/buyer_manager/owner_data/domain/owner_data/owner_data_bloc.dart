import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../config/logs/log.dart';
import '../../../../shared/_data/models/auto_info.dart';
import '../../data/models/owner_data.dart';
import '../../data/repositories/owner_data_repository.dart';

part 'generated/owner_data_bloc.freezed.dart';
part 'owner_data_event.dart';
part 'owner_data_state.dart';

@lazySingleton
class OwnerDataBloc extends Bloc<OwnerDataEvent, OwnerDataState> {
  final OwnerDataRepository repository;

  OwnerDataBloc(this.repository) : super(const _Loading()) {
    on<Load>(_load);
  }

  Future<void> _load(
    Load event,
    Emitter<OwnerDataState> emit,
  ) async {
    emit(const _Loading());

    try {
      if (event.iin == null || event.autoInfo?.id == null) {
        emit(const _Error('Order Id not specified'));

        return;
      }

      final response =
          await repository.getOwnerData(event.iin!, event.autoInfo!.id);
      emit(_Loaded(response));
    } on DioException catch (e) {
      logger.e('e: $e');
      emit(_Error('${e.message}\nПроизошла ошибка при загрузке данных'));
    }
  }
}
