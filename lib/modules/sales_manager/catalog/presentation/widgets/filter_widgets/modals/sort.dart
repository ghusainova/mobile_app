import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../../config/injectable/injectable.dart';
import '../../../../../../../components/UI/radio_button_tile/radio_button_tile_widget.dart';
import '../../../../data/enum/filter_sort_enum.dart';
import '../../../../../../../components/widgets/buttons/buttons_bar.dart';
import '../../../../../../../components/UI/modal_appbar.dart';
import '../../../../domain/filter_bloc/filter_bloc.dart';

class Sort extends StatefulWidget {
  const Sort({super.key});

  @override
  State<Sort> createState() => _SortState();
}

class _SortState extends State<Sort> {
  final filterBloc = getIt.get<FilterBloc>();
  var selectedSorting = FilterSortEnum.latest;

  @override
  void initState() {
    super.initState();
    selectedSorting = filterBloc.currentFilter.sortBy;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ModalAppBar(text: 'Сортировка'),
          ...FilterSortEnum.values.map(
            (e) => RadioButtonTileWidget(
              title: e.label,
              enabled: selectedSorting == e,
              onTap: () => setState(() => selectedSorting = e),
            ),
          ),
          const SizedBox(height: 16),
          ButtonsBar(
            onClear: () => onConfirm(clear: true),
            onConfirm: onConfirm,
          ),
        ],
      ),
    );
  }

  void onConfirm({bool clear = false}) {
    if (clear) {
      selectedSorting = FilterSortEnum.latest;
    }

    final updatedFilter =
        filterBloc.currentFilter.copyWith(sortBy: selectedSorting);

    filterBloc.add(GetFilteredData(filter: updatedFilter));
    context.pop();
  }
}
