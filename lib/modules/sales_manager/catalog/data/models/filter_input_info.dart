class FilterInputInfo {
  String label;
  List<FilterInputItem> fields;

  FilterInputInfo({
    required this.label,
    required this.fields,
  });
}

class FilterInputItem {
  String fieldName;
  String hintText;
  bool useNumericKeyboard;
  bool usePriceFormatter;

  FilterInputItem({
    required this.fieldName,
    required this.hintText,
    this.useNumericKeyboard = false,
    this.usePriceFormatter = false,
  });
}
