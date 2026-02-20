enum FilterSortEnum {
  latest,
  lowestPrice,
  highestPrice,
  newerYear,
  olderYear,
}

extension FilterSortEnumExt on FilterSortEnum {
  String? get code {
    switch (this) {
      case FilterSortEnum.latest:
        return null;
      case FilterSortEnum.lowestPrice:
        return 'lowerPrice:asc';
      case FilterSortEnum.highestPrice:
        return 'upperPrice:desc';
      case FilterSortEnum.newerYear:
        return 'upperYear:desc';
      case FilterSortEnum.olderYear:
        return 'lowerYear:asc';
    }
  }

  String get label {
    switch (this) {
      case FilterSortEnum.latest:
        return 'Сначала последнее поступление';
      case FilterSortEnum.lowestPrice:
        return 'Сначала дешевые';
      case FilterSortEnum.highestPrice:
        return 'Сначала дорогие';
      case FilterSortEnum.newerYear:
        return 'Новее по году выпуска';
      case FilterSortEnum.olderYear:
        return 'Старше по году выпуска';
    }
  }

  List<String> get labelList =>
      FilterSortEnum.values.map((e) => e.label).toList();
}
