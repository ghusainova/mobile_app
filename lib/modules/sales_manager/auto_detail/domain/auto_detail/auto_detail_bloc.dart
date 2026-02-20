import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../config/injectable/injectable.dart';
import '../../data/enums/photo_type_enum.dart';
import '../../../../shared/_data/models/auto_info.dart';
import '../../data/repositories/auto_detail_repository.dart';
import '../photos/photos_bloc.dart';

part 'auto_detail_event.dart';
part 'auto_detail_state.dart';
part 'generated/auto_detail_bloc.freezed.dart';

class AutoDetailBloc extends Bloc<AutoDetailEvent, AutoDetailState> {
  AutoDetailBloc() : super(const Loading()) {
    on<Load>(_onLoad);
    on<Reload>(_onReload);
  }

  final _autoDetailRepository = getIt.get<AutoDetailRepository>();
  AutoInfo? get autoInfo => state is Loaded ? (state as Loaded).autoInfo : null;

  void registerInjection() {
    if (!getIt.isRegistered<AutoDetailBloc>()) {
      getIt.registerFactory(() => AutoDetailBloc());
    }
  }

  void unregisterInjection() => getIt.unregister<AutoDetailBloc>();

  Future<void> _onLoad(Load event, Emitter<AutoDetailState> emit) async {
    emit(const Loading());

    if (event.autoInfo != null && event.orderId == null) {
      emit(Loaded(autoInfo: event.autoInfo!));
      return;
    }

    if (event.orderId == null) {
      emit(const Error('Order Id not specified'));
      return;
    }

    try {
      final autoInfo = await _autoDetailRepository.getAutoAuto(event.orderId!);

      if (autoInfo != null) {
        emit(Loaded(autoInfo: autoInfo));
      }
    } on DioException catch (e) {
      emit(Error(e.message));
      emit(const NoContent());
    }
  }

  Future<void> _onReload(Reload event, Emitter<AutoDetailState> emit) async {
    add(AutoDetailEvent.load(orderId: autoInfo?.id));
  }

  Future<String?> getOldCarInspectionList(String orderId) async {
    final photosBloc = getIt.get<PhotosBloc>();
    final response = await photosBloc.getPhotos(
      orderId,
      PhotoTypeEnum.techReview.documentType,
    );
    photosBloc.close();

    if ((response ?? []).isNotEmpty && response!.first != null) {
      return response.first!.s3Link;
    }

    return null;
  }
}
