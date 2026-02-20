import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../config/injectable/injectable.dart';
import '../../../../shared/_data/models/auto_info.dart';
import '../../../client_processing/data/models/approved_credit/get_auto_request_body.dart';
import '../../data/repositories/auto_detail_repository.dart';
import '../../../../../modules/shared/login/domain/user/user_bloc.dart';

part 'generated/similar_auto_bloc.freezed.dart';
part 'similar_auto_event.dart';
part 'similar_auto_state.dart';

class SimilarAutoBloc extends Bloc<SimilarAutoEvent, SimilarAutoState> {
  SimilarAutoBloc() : super(const Loading()) {
    on<Load>(_load);
  }

  static final _autoDetailRepository = getIt.get<AutoDetailRepository>();
  static final _userBloc = getIt.get<UserBloc>();

  void registerInjection() {
    if (!getIt.isRegistered<SimilarAutoBloc>()) {
      getIt.registerFactory(() => SimilarAutoBloc());
    }
  }

  void unregisterInjection() => getIt.unregister<SimilarAutoBloc>();

  Future<void> _load(
    SimilarAutoEvent event,
    Emitter<SimilarAutoState> emit,
  ) async {
    emit(const Loading());

    try {
      final requestBody = GetAutoRequestBody.fromAutoInfo(event.autoInfo);

      final response = await _autoDetailRepository.getSimilarAutoCatalog(
        _userBloc.user?.serviceId,
        requestBody,
      );

      if (response.orders.isNotEmpty) {
        emit(HasContent(similarAutoCatalog: response.orders));
      }
    } on DioException catch (e) {
      emit(Error(e.message));
    }
  }
}
