import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../credit_application/domain/credit_application/credit_application_bloc.dart';
import '../../data/models/credit_documents.dart';
import '../../data/repositories/credit_documents_repository.dart';

part 'credit_documents_event.dart';
part 'credit_documents_state.dart';
part 'generated/credit_documents_bloc.freezed.dart';

class CreditDocumentsBloc
    extends Bloc<CreditDocumentsEvent, CreditDocumentsState> {
  final CreditDocumentsRepository repository;
  final CreditApplicationBloc aplBloc;

  CreditDocumentsBloc(
    this.repository,
    this.aplBloc,
  ) : super(const Loading()) {
    on<Load>(_onLoad);
  }

  Future<void> _onLoad(Load event, Emitter<CreditDocumentsState> emit) async {
    emit(const Loading());

    if (aplBloc.carLoanOrder?.client.iin == null) {
      emit(const Error('Client iin is not specified'));
      return;
    }

    try {
      final creditDocs =
          await repository.getCreditDocuments(aplBloc.carLoanOrder!.client.iin);

      if (creditDocs.documentBase64.isEmpty) {
        emit(const Error('Документы не найдены'));
      } else {
        emit(Loaded(creditDocs));
      }
    } on DioException catch (e) {
      emit(Error(e.message));
    }
  }
}
