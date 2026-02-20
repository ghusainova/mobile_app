import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/models/filter.dart';
import '../../../../data/models/filter_input_info.dart';
import '../../../../../../../components/widgets/card_widget/card_widget.dart';
import '../../../../../../shared/_domain/utility/formatters/price_input_formatter.dart';
import '../../../../../../../components/widgets/text_field_widget.dart';
import '../../../../domain/filter_bloc/filter_bloc.dart';
import 'chip_form.dart';

class FilteredTextFieldForm extends StatelessWidget {
  final FilterInputInfo filterInfo;

  const FilteredTextFieldForm({
    required this.filterInfo,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterBloc, FilterState>(
      builder: (context, state) {
        final filterMap = context.read<FilterBloc>().currentFilter.toJson();

        return CardWidget(
          margin: const EdgeInsets.only(bottom: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FormTitle(title: filterInfo.label, context: context),
              const SizedBox(height: 24),
              inputForm(context, filterMap),
            ],
          ),
        );
      },
    );
  }

  Row inputForm(
    BuildContext context,
    Map<String, dynamic> filterMap,
  ) {
    return Row(
      children: filterInfo.fields
          .map(
            (e) => Expanded(
              child: Padding(
                padding:
                    filterInfo.fields.length > 1 && e == filterInfo.fields.first
                        ? const EdgeInsets.only(right: 16)
                        : EdgeInsets.zero,
                child: TextFieldWidget(
                  textController: TextEditingController(
                    text: filterMap[e.fieldName] ?? '',
                  ),
                  labelText: e.hintText,
                  usePriceFormatter: e.usePriceFormatter,
                  upperCaseFormatter: true,
                  keyboardType:
                      e.useNumericKeyboard ? TextInputType.number : null,
                  onTextChanged: (text) => _updateFilter(
                    context,
                    e,
                    text,
                    usePriceFormatter: e.usePriceFormatter,
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  void _updateFilter(
    BuildContext context,
    FilterInputItem e,
    String text, {
    bool usePriceFormatter = false,
  }) {
    final filterMap = context.read<FilterBloc>().currentFilter.toJson();

    filterMap[e.fieldName] =
        usePriceFormatter ? removePriceSeparators(text) : text;

    context.read<FilterBloc>().add(
          SetFilter(Filter.fromJson(filterMap)),
        );
  }
}
