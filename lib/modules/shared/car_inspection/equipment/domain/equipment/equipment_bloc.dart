import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../_data/models/auto_info.dart';
import '../../../shared/data/models/equipment.dart';
import '../../../shared/data/repositories/car_inspection_repository.dart';

part 'equipment_event.dart';
part 'equipment_state.dart';
part 'generated/equipment_bloc.freezed.dart';

@singleton
class EquipmentBloc extends Bloc<EquipmentEvent, EquipmentState> {
  final CarInspectionRepository repository;

  EquipmentBloc(this.repository) : super(const Loading()) {
    on<Load>(_load);
  }

  Map<String, List<Equipment>>? get equipment =>
      state is HasContent ? (state as HasContent).equipment : null;

  Future<void> _load(
    EquipmentEvent event,
    Emitter<EquipmentState> emit,
  ) async {
    emit(const EquipmentState.loading());

    if (event.autoInfo == null) {
      emit(const Error('Order Id not specified'));
      return;
    }

    try {
      final equipment = await repository.getEquipment(event.autoInfo!.id);

      if (equipment == null || isMapEmpty(equipment)) {
        emit(const NoContent());
      } else {
        emit(HasContent(equipment: equipment));
      }
    } on DioException catch (e) {
      emit(Error(e.message));
    }
  }

  bool isMapEmpty(Map<String, List<Equipment>> equipment) {
    for (final value in equipment.values) {
      if (value.isNotEmpty) {
        return false;
      }
    }
    return true;
  }
}
