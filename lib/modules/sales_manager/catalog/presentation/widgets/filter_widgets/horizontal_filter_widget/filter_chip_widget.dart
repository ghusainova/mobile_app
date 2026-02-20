import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../data/constants/filter_constants.dart';
import '../../../../data/models/filter.dart';
import '../../../../../../../components/styles/app_assets.dart';
import '../../../../../../../components/styles/app_colors.dart';
import '../../../../../../shared/_domain/utility/formatters/price_input_formatter.dart';
import '../../../../../../shared/_domain/utility/formatters/truncate_string.dart';
import '../../../../domain/filter_bloc/filter_bloc.dart';
import '../modals/filter_modal.dart';

class FilterChipWidget extends StatelessWidget {
  final ChipInfo chipInfo;

  const FilterChipWidget({
    required this.chipInfo,
    super.key,
  });

  bool get _isMainFilterChip => chipInfo.label == 'Все';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterBloc, FilterState>(
      builder: (context, state) {
        final filter = context.read<FilterBloc>().currentFilter;
        final filterMap = filter.toJson();
        final isSelected = _isSelected(context, filter);
        final selectedFilterCount = filterMap.values
            .where(
              (element) => element != null && element.toString().isNotEmpty,
            )
            .length;

        return Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 6, right: 8),
              child: InputChip(
                label: _isMainFilterChip
                    ? SvgPicture.asset(AppAssets.filterIcon)
                    : Text(
                        _getChipDataLabel(filterMap),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                labelPadding: EdgeInsets.only(left: isSelected ? 6 : 23),
                selected: false,
                backgroundColor: Colors.white,
                selectedColor: Colors.white,
                color: WidgetStateProperty.all<Color>(Colors.white),
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: isSelected ? Colors.red : AppColors.borderDark,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                onPressed: () => _onFilterChanged(context),
                onDeleted: () => _onClear(context),
                deleteIcon: isSelected
                    ? const Icon(Icons.clear, color: Colors.grey, size: 16)
                    : const SizedBox(),
              ),
            ),
            Positioned(
              right: 4,
              child: Badge(
                label: Text('$selectedFilterCount'),
                isLabelVisible: _isMainFilterChip && selectedFilterCount > 0,
              ),
            ),
          ],
        );
      },
    );
  }

  String _getChipDataLabel(Map<String, dynamic> filterMap) {
    String dataLabel = '';

    for (var i in chipInfo.fields) {
      dataLabel = _mapDataLabel(dataLabel, i, filterMap);
    }

    if (dataLabel.isEmpty) {
      return chipInfo.label;
    }

    return '${chipInfo.label}: $dataLabel';
  }

  String _mapDataLabel(
    String dataLabel,
    String? key,
    Map<String, dynamic> filterMap,
  ) {
    final value = filterMap[key];
    if (value == null) {
      return dataLabel;
    }

    final fieldName =
        filterMap.entries.firstWhereOrNull((element) => element.value == value);
    final labelPrefix = priceInfo.fields
            .firstWhereOrNull((element) => element.fieldName == fieldName?.key)
            ?.hintText ??
        '';

    if (dataLabel.isEmpty) {
      return chipInfo.usePriceFormatter
          ? '$labelPrefix ${formatPriceText(value)} ₸'.trim().toLowerCase()
          : value;
    } else {
      return chipInfo.usePriceFormatter
          ? '$dataLabel / до ${formatPriceText(value)} ₸'
          : '${truncateWithEllipsis(text: dataLabel)}/${truncateWithEllipsis(text: value)}';
    }
  }

  Future<void> _onFilterChanged(BuildContext context) async {
    final filterBloc = context.read<FilterBloc>();
    final isFilterChanged = await openFilterModal(context, chipInfo.label);

    if (isFilterChanged == true) {
      filterBloc.add(const GetFilteredData());
    }
  }

  void _onClear(BuildContext context) {
    context.read<FilterBloc>().add(const ClearFilter());
  }

  bool _isSelected(BuildContext context, Filter filter) =>
      chipInfo.fields.any((element) => filter.toJson()[element] != null);
}
