import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../data/models/filter.dart';
import '../order_list/catalog_bloc.dart';

part 'filter_event.dart';
part 'filter_state.dart';
part 'generated/filter_bloc.freezed.dart';

@lazySingleton
class FilterBloc extends Bloc<FilterEvent, FilterState> {
  final CatalogBloc catalogBloc;

  FilterBloc(this.catalogBloc) : super(const _EmptyFilter()) {
    on<SetFilter>(_onSetFilter);
    on<GetFilteredData>(_onGetFilteredData);
    on<SearchByText>(_onSearchByText);
    on<ClearFilter>(_onClearFilter);
  }

  Filter _filter = const Filter();

  Filter get currentFilter => _filter;

  void _onSetFilter(
    SetFilter event,
    Emitter<FilterState> emit,
  ) {
    emit(const _Loading());
    _filter = event.filter;
    emit(FilledFilter(event.filter));
  }

  void _onGetFilteredData(
    GetFilteredData event,
    Emitter<FilterState> emit,
  ) {
    emit(const _Loading());

    if (event.filter != null) {
      _filter = event.filter!;
    }

    _filter = _filter.copyWith(searchValue: null);
    catalogBloc.add(LoadCatalog(filter: _filter));
    emit(FilledFilter(_filter));
  }

  void _onSearchByText(
    SearchByText event,
    Emitter<FilterState> emit,
  ) {
    emit(const _Loading());

    _filter = Filter(searchValue: event.searchValue);
    catalogBloc.add(LoadCatalog(filter: _filter));

    emit(FilledFilter(_filter));
  }

  void _onClearFilter(
    ClearFilter event,
    Emitter<FilterState> emit,
  ) {
    emit(const _Loading());
    _filter = const Filter();
    emit(const _EmptyFilter());
    catalogBloc.add(const LoadCatalog());
  }
}
