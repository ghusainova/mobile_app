part of 'filter_bloc.dart';

@freezed
class FilterState with _$FilterState {
  const factory FilterState.loading() = _Loading;
  const factory FilterState.emptyFilter() = _EmptyFilter;
  const factory FilterState.filledFilter(Filter filter) = FilledFilter;
}
