import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../shared/_data/helpers/round_string.dart';
import '../../../../shared/additional_info/data/enums/additional_info_param_enum.dart';
import '../../../credit_application/domain/credit_application/credit_application_bloc.dart';
import '../../data/models/credit_additional_info.dart';
import '../../data/models/credit_additional_response.dart';
import '../../data/repositories/credit_additional_info_repository.dart';

part 'credit_additional_info_event.dart';
part 'credit_additional_info_state.dart';
part 'generated/credit_additional_info_bloc.freezed.dart';

@lazySingleton
class CreditAdditionalInfoBloc
    extends Bloc<CreditAdditionalInfoEvent, CreditAdditionalInfoState> {
  final CreditAdditionalInfoRepository repository;
  final CreditApplicationBloc aplBloc;
  CreditAdditionalInfoBloc(this.repository, this.aplBloc)
      : super(const Loading()) {
    on<Load>(_onLoad);
    on<ChangeAdditionalInfo>(_onChangeAdditionalInfo);
    on<Save>(_onSave);
  }

  CreditAdditionalInfo additionalInfo = const CreditAdditionalInfo();

  Future<void> _onLoad(
    Load event,
    Emitter<CreditAdditionalInfoState> emit,
  ) async {
    emit(const Loading());

    if (aplBloc.orderId == null) {
      emit(const Error('Order Id not specified'));
      return;
    }

    try {
      final response = await repository.getAdditionalInfo(aplBloc.orderId!);
      additionalInfo = response.auto;
      emit(Loaded(additionalInfo: additionalInfo));
    } on DioException catch (e) {
      emit(Error('${e.message} \nНе удалось получить данные'));
    }
  }

  void _onChangeAdditionalInfo(
    ChangeAdditionalInfo event,
    Emitter<CreditAdditionalInfoState> emit,
  ) {
    final infoJson = additionalInfo.toJson();
    emit(const Loading());
    if (infoJson.containsKey(event.param.name)) {
      infoJson[event.param.name] = event.value;
    }

    additionalInfo = CreditAdditionalInfo.fromJson(infoJson);
    emit(
      Loaded(
        additionalInfo: additionalInfo,
      ),
    );
  }

  Future<void> _onSave(
    Save event,
    Emitter<CreditAdditionalInfoState> emit,
  ) async {
    emit(const Loading());

    if (aplBloc.orderId == null) {
      emit(const Error('Order Id not specified'));
      return;
    }

    try {
      await repository.setAdditionalInfo(
        aplBloc.orderId!,
        CreditAdditionalResponse(
          auto: additionalInfo.copyWith(
            engine: roundString(additionalInfo.engine),
          ),
        ),
      );

      emit(const Saved());
      emit(Loaded(additionalInfo: additionalInfo));
    } on DioException catch (e) {
      emit(Error('${e.message} \nНе удалось сохранить данные'));
    }
  }
}
