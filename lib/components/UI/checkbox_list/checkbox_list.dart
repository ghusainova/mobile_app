import 'package:flutter/material.dart';

import 'checkbox_list_item.dart';

class CheckboxList extends StatefulWidget {
  final List<String> values;
  final List<String> selectedValues;
  final bool isScrollable;
  final void Function(List<String> selectedItems)? onSelect;
  final void Function(String name, bool? status)? onChange;

  const CheckboxList({
    required this.values,
    required this.selectedValues,
    super.key,
    this.isScrollable = false,
    this.onSelect,
    this.onChange,
  });

  @override
  State<CheckboxList> createState() => _CheckboxListState();
}

class _CheckboxListState extends State<CheckboxList> {
  List<String> selectedItems = [];

  @override
  void initState() {
    super.initState();
    selectedItems = widget.selectedValues;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics:
          widget.isScrollable ? null : const NeverScrollableScrollPhysics(),
      itemCount: widget.values.length,
      itemBuilder: (context, index) => CheckboxItem(
        title: widget.values[index],
        isSelected: selectedItems.contains(widget.values[index]),
        onSelect: (status) => onChangeValue(widget.values[index], status),
      ),
    );
  }

  void onChangeValue(String value, bool? status) {
    if (selectedItems.contains(value)) {
      setState(
        () => selectedItems =
            selectedItems.where((element) => element != value).toList(),
      );
    } else {
      setState(() => selectedItems = [...selectedItems, value]);
    }

    if (widget.onSelect != null) {
      widget.onSelect!(selectedItems);
    } else if (widget.onChange != null) {
      widget.onChange!(value, status);
    }
  }
}
