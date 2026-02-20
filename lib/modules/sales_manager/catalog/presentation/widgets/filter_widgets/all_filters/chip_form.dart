import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../data/models/chip_form_info.dart';
import '../../../../data/models/filter.dart';
import '../../../../../../../components/styles/app_colors.dart';
import '../../../../../../../components/widgets/card_widget/card_widget.dart';
import '../../../../domain/filter_bloc/filter_bloc.dart';

class FilterChipForm extends StatefulWidget {
  final ChipFormInfo chipFormInfo;

  const FilterChipForm({required this.chipFormInfo, super.key});

  @override
  State<FilterChipForm> createState() => _FilterChipFormState();
}

class _FilterChipFormState extends State<FilterChipForm> {
  String? _selectedOption;

  @override
  void initState() {
    super.initState();

    final filterBloc = context.read<FilterBloc>();
    final filter = filterBloc.currentFilter;
    final filterMap = filter.toJson();
    _selectedOption = filterMap[widget.chipFormInfo.field];
  }

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      margin: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FormTitle(title: widget.chipFormInfo.label, context: context),
          const SizedBox(height: 24),
          _optionsList(),
        ],
      ),
    );
  }

  Widget _optionsList() {
    return Wrap(
      children: widget.chipFormInfo.options.map((option) {
        return _optionItem(option);
      }).toList(),
    );
  }

  Widget _optionItem(String option) {
    bool isSelected = _selectedOption == option;
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: ChoiceChip(
        label: Text(
          toBeginningOfSentenceCase(option.toLowerCase()),
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        backgroundColor: Colors.white,
        selectedColor: Colors.white,
        side: BorderSide(
          color: isSelected ? Colors.red : AppColors.lightGray,
          width: 2,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        selected: isSelected,
        onSelected: (bool isSelected) {
          if (mounted) {
            setState(() {
              _selectedOption = isSelected ? option : null;
              widget.chipFormInfo.chosenOption = _selectedOption;
            });
          }

          final filterBloc = context.read<FilterBloc>();
          final filter = filterBloc.currentFilter;
          final filterMap = filter.toJson()
            ..update(widget.chipFormInfo.field, (value) => _selectedOption);
          final updatedFilter = Filter.fromJson(filterMap);
          filterBloc.add(SetFilter(updatedFilter));
        },
      ),
    );
  }
}

class FormTitle extends StatelessWidget {
  const FormTitle({
    required this.title,
    required this.context,
    super.key,
  });

  final String title;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headlineSmall,
    );
  }
}
