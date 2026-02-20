part of 'filter_bloc.dart';

@freezed
class FilterEvent with _$FilterEvent {
  const factory FilterEvent.setFilter(Filter filter) = SetFilter;
  const factory FilterEvent.getFilteredData({Filter? filter}) = GetFilteredData;
  const factory FilterEvent.searchByText(String? searchValue) = SearchByText;
  const factory FilterEvent.clearFilter() = ClearFilter;
}
