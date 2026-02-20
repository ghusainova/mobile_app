import 'package:flutter/material.dart';

import '../../../../../../../../components/UI/modal_appbar.dart';
import '../../../../../../../../components/UI/search_bar_widget.dart';

class TireContentListWidget extends StatefulWidget {
  final List<String> tireBrands;
  final void Function(String selectedBrand) onSelect;

  const TireContentListWidget({
    required this.tireBrands,
    required this.onSelect,
    super.key,
  });

  @override
  State<TireContentListWidget> createState() => _TireContentListWidgetState();
}

class _TireContentListWidgetState extends State<TireContentListWidget> {
  List<String> tireBrands = [];

  @override
  void initState() {
    super.initState();
    tireBrands = widget.tireBrands;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(16),
          child: ModalAppBar(text: 'Шины'),
        ),
        SearchBarWidget(
          labelText: 'Поиск',
          searchOnEachTap: true,
          onSearch: onSearch,
        ),
        Expanded(
          child: RawScrollbar(
            thumbVisibility: true,
            child: ListView.builder(
              itemCount: tireBrands.length,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemBuilder: (context, index) => ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(tireBrands[index]),
                trailing: const Icon(Icons.keyboard_arrow_right),
                onTap: () => widget.onSelect(tireBrands[index]),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void onSearch(String searchField) {
    if (searchField.isEmpty) {
      tireBrands = widget.tireBrands;
    } else {
      tireBrands = tireBrands.where((text) {
        final regex = RegExp(searchField, caseSensitive: false);
        final hasMatch = regex.hasMatch(text);

        return hasMatch;
      }).toList();
    }

    setState(() {});
  }
}
