import 'package:flutter/material.dart';

class BrandListWidget extends StatelessWidget {
  final List<String> brands;
  final void Function(String selectedBrand) onSelect;

  const BrandListWidget({
    required this.brands, required this.onSelect, super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: brands.length,
      itemBuilder: (context, index) => ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(brands[index]),
        trailing: const Icon(Icons.keyboard_arrow_right),
        onTap: () => onSelect(brands[index]),
      ),
    );
  }
}
