const List<String> _itemsToExcludeFromValidation = [
  'Работоспособность подогрева',
  'Инструменты',
  'Коврики',
];

bool checkItemToExclude(String itemName) {
  return !_itemsToExcludeFromValidation
      .any((element) => itemName.contains(element));
}
//TODO: refactor: move to equipment_inspection?