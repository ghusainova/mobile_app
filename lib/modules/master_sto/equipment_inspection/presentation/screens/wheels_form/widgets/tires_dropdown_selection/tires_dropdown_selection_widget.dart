import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../config/injectable/injectable.dart';
import '../../../../../../../../components/widgets/text_field_read_only.dart';
import '../../../../../data/models/inspection_item/inspection_item.dart';
import '../../../../../domain/tires/tires_bloc.dart';
import 'seasons_list_modal.dart';
import 'tires_brand_list_modal.dart';

class TireDropdownSelectionWidget extends StatefulWidget {
  final String? title;
  final bool isMultiSelect;
  final InspectionItem item;
  final void Function(InspectionItem items) onChanged;

  const TireDropdownSelectionWidget({
    required this.isMultiSelect,
    required this.item,
    required this.onChanged,
    super.key,
    this.title,
  });

  @override
  State<TireDropdownSelectionWidget> createState() =>
      _TireDropdownSelectionWidgetState();
}

class _TireDropdownSelectionWidgetState
    extends State<TireDropdownSelectionWidget> {
  late InspectionItem item;

  @override
  void initState() {
    super.initState();
    item = widget.item;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: item.values.asMap().entries.map((e) {
          return TextFieldReadOnly(
            initialText: e.value.subValues
                    .firstWhereOrNull((element) => element.selected)
                    ?.name ??
                '',
            labelText: e.value.name,
            margin: e.value == item.values.first
                ? EdgeInsets.zero
                : const EdgeInsets.only(top: 16),
            onTap: () => showModals(e.value.name, e.key),
          );
        }).toList(),
      ),
    );
  }

  void showModals(String name, int index) {
    if (name == 'Марка') {
      showBrandSelection(index);
    } else if (name == 'Сезонность') {
      showSeasonSelection(index);
    }
  }

  Future<void> showBrandSelection(int index) async {
    getIt.get<TiresBloc>().add(const GetTiresBrands());

    final selectedBrand = await showModal(
          const TiresBrandListModal(),
          isScrollControlled: true,
        ) ??
        '';

    if (selectedBrand.isNotEmpty) {
      item = InspectionItem.updateTireBrandSelection(
        item: item,
        value: item.values[index],
        brand: selectedBrand,
      );

      widget.onChanged(item);

      if (mounted && selectedBrand.isNotEmpty) {
        showSeasonSelection(index + 1);
      }
    }
  }

  Future<void> showSeasonSelection(int index) async {
    if (item.values.isEmpty || !item.values.asMap().containsKey(index)) {
      return;
    }

    final subValues = item.values[index].subValues;
    final initialSeason =
        subValues.firstWhereOrNull((element) => element.selected)?.name ?? '';
    final selectedSeason = await showModal(
          SeasonsListModal(
            seasonsList: subValues.map((e) => e.name).toList(),
            selectedSeason: initialSeason,
          ),
        ) ??
        '';

    if (selectedSeason.isNotEmpty) {
      item = InspectionItem.updateTireSeasonSelection(
        item: item,
        value: item.values[index],
        season: selectedSeason,
      );

      widget.onChanged(item);
    }
  }

  Future<String?> showModal(
    Widget modal, {
    bool isScrollControlled = false,
  }) async {
    return await showModalBottomSheet<String?>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
      isScrollControlled: isScrollControlled,
      builder: (context) => modal,
    );
  }
}
