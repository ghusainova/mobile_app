import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../config/injectable/injectable.dart';
import '../../../../../../../components/UI/checkbox_list/checkbox_list.dart';
import '../../../../data/models/filter.dart';
import '../../../../../../../components/widgets/buttons/buttons_bar.dart';
import '../../../../../../../components/UI/modal_appbar.dart';
import '../../../../domain/filter_bloc/filter_bloc.dart';

class LovModal extends StatelessWidget {
  final String title;
  final String field;
  final List<String> options;

  const LovModal({
    required this.title,
    required this.field,
    required this.options,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt.get<FilterBloc>(),
      child: BlocBuilder<FilterBloc, FilterState>(
        builder: (context, state) {
          final filter = context.read<FilterBloc>().currentFilter;
          final filterMap = filter.toJson();

          return FractionallySizedBox(
            heightFactor: 0.8,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ModalAppBar(text: title),
                  options.isEmpty
                      ? Text(
                          'Список пуст',
                          style: Theme.of(context).textTheme.bodyMedium,
                        )
                      : Expanded(
                          child: CheckboxList(
                            values: options,
                            selectedValues:
                                fromStringToList(filterMap[field]) ?? [],
                            onSelect: (items) =>
                                filterMap[field] = fromStringListToJson(items),
                          ),
                        ),
                  _buttons(context, filterMap),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buttons(BuildContext context, Map<String, dynamic> filterMap) {
    return ButtonsBar(
      onClear: () => _setFilter(context, filterMap, clear: true),
      onConfirm: () => _setFilter(context, filterMap),
    );
  }

  void _setFilter(
    BuildContext context,
    Map<String, dynamic> filterMap, {
    bool clear = false,
  }) {
    bool isFilterChanged = false;

    if (clear) {
      filterMap[field] = null;
    }

    isFilterChanged =
        context.read<FilterBloc>().currentFilter.toJson() != filterMap;
    final updatedFilter = Filter.fromJson(filterMap);

    context.read<FilterBloc>().add(SetFilter(updatedFilter));
    Navigator.of(context).pop(isFilterChanged);
  }
}
