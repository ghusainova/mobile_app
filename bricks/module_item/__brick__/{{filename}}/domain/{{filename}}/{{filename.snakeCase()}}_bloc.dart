import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../data/models/{{filename.snakeCase()}}.dart';
import '../../data/repositories/{{filename.snakeCase()}}_repository.dart';

part '{{filename.snakeCase()}}_event.dart';
part '{{filename.snakeCase()}}_state.dart';
part 'generated/{{filename.snakeCase()}}_bloc.freezed.dart';

@lazySingleton
class {{filename.pascalCase()}}Bloc extends Bloc<{{filename.pascalCase()}}Event, {{filename.pascalCase()}}State> {
  final {{filename.pascalCase()}}Repository repository;

  {{filename.pascalCase()}}Bloc(
    this.repository,
  ) : super(const Loading()) {
    on<Load>(_onLoad);
  }

  {{filename.pascalCase()}}? get {{filename.camelCase()}} => state is Loaded ? (state as Loaded).{{filename.camelCase()}} : null;


  Future<void> _onLoad(Load event, Emitter<{{filename.pascalCase()}}State> emit) async {
    emit(const Loading());

     try {
      final {{filename.camelCase()}} =
          await repository.get{{filename.pascalCase()}}();

      emit({{filename.pascalCase()}}State.loaded({{filename.camelCase()}}: {{filename.camelCase()}}));
    } on DioException catch (e) {
      emit(Error(e.message));
    }
  }
}
