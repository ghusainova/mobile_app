import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../credit_application/data/models/credit_application.dart';
import '../../../credit_application/data/repositories/credit_application_repository.dart';

part 'applications_in_progress_event.dart';
part 'applications_in_progress_state.dart';
part 'generated/applications_in_progress_bloc.freezed.dart';

@lazySingleton
class ApplicationsInProgressBloc
    extends Bloc<ApplicationsInProgressEvent, ApplicationsInProgressState> {
  final CreditApplicationRepository repository;

  ApplicationsInProgressBloc(
    this.repository,
  ) : super(const Loading()) {
    on<Load>(_onLoad);
    on<Search>(_onSearch);
  }

  Future<void> _onLoad(
    Load event,
    Emitter<ApplicationsInProgressState> emit,
  ) async {
    emit(const Loading());

    try {
      final applicationsInProgress =
          await repository.getCreditApplicationList();

      if (applicationsInProgress.isNotEmpty) {
        emit(
          ApplicationsInProgressState.loaded(
            applicationsInProgress: applicationsInProgress,
          ),
        );
      } else {
        emit(const NoContent());
      }
    } on DioException catch (e) {
      emit(Error(e.message));
      emit(const NoContent());
    }
  }

  Future<void> _onSearch(
    Search event,
    Emitter<ApplicationsInProgressState> emit,
  ) async {
    emit(const Loading());

    try {
      final searchResponse =
          await repository.searchCreditApplications(event.searchParam);

      if (searchResponse.isNotEmpty) {
        emit(Loaded(applicationsInProgress: searchResponse));
      } else {
        emit(const NoContent());
      }
    } on DioException catch (e) {
      emit(Error(e.message));
      emit(const NoContent());
    }
  }
}
