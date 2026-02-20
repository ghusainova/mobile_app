import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../shared/_data/models/auto_info.dart';
import '../../data/models/filter.dart';
import '../../data/repositories/catalog_repository.dart';
import '../../../../../modules/shared/login/domain/user/user_bloc.dart';

part 'catalog_event.dart';
part 'catalog_state.dart';
part 'generated/catalog_bloc.freezed.dart';

@singleton
class CatalogBloc extends Bloc<CatalogEvent, CatalogState> {
  final CatalogRepository catalogRepository;
  final UserBloc userBloc;

  CatalogBloc({
    required this.catalogRepository,
    required this.userBloc,
  }) : super(const LoadingList()) {
    on<LoadCatalog>(_onLoad);
  }

  static bool _isAppendLoading = false;

  bool get isAppendLoading => _isAppendLoading;

  Future<void> _onLoad(
    LoadCatalog event,
    Emitter<CatalogState> emit,
  ) async {
    final isAppend = event.offset != null;

    if (isAppend) {
      _isAppendLoading = true;
    } else {
      _isAppendLoading = false;
      emit(const LoadingList());
    }

    try {
      final response = await catalogRepository.getAutoCatalog(
        serviceId: userBloc.user?.serviceId ?? '',
        offset: event.offset,
        filter: event.filter,
      );

      if (response.orders.isNotEmpty) {
        final catalogList = isAppend
            ? (event.prevContent ?? []) + response.orders
            : response.orders;

        emit(HasContent(catalogList));
      } else if (!isAppend) {
        emit(const EmptyList());
      }

      _isAppendLoading = false;
    } on DioException catch (e) {
      _isAppendLoading = false;
      emit(_Error(e.message));
      emit(const EmptyList());
    }
  }
}
