import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../config/injectable/injectable.dart';
import '../../../../../../../components/widgets/buttons/buttons_bar.dart';
import '../../../../../../shared/_domain/utility/formatters/price_input_formatter.dart';
import '../../../../../../../components/widgets/text_field_widget.dart';
import '../../../../../../../components/UI/modal_appbar.dart';
import '../../../../domain/filter_bloc/filter_bloc.dart';

class PriceModal extends StatelessWidget {
  const PriceModal({super.key});

  static final lowerPricetextController = TextEditingController();
  static final upperPricetextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt.get<FilterBloc>(),
      child: BlocBuilder<FilterBloc, FilterState>(
        builder: (context, state) {
          final filter = context.read<FilterBloc>().currentFilter;
          lowerPricetextController.text =
              formatPriceText(filter.lowerPrice ?? '');
          upperPricetextController.text =
              formatPriceText(filter.upperPrice ?? '');

          return Container(
            height: 238,
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ModalAppBar(text: 'Цена, ₸'),
                Row(
                  children: [
                    Expanded(
                      child: TextFieldWidget(
                        textController: lowerPricetextController,
                        labelText: 'От',
                        keyboardType: TextInputType.number,
                        usePriceFormatter: true,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFieldWidget(
                        textController: upperPricetextController,
                        labelText: 'До',
                        keyboardType: TextInputType.number,
                        usePriceFormatter: true,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ButtonsBar(
                  onClear: () => _setFilter(context, clear: true),
                  onConfirm: () => _setFilter(context),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _setFilter(BuildContext context, {bool clear = false}) {
    final filter = context.read<FilterBloc>().currentFilter;

    if (clear) {
      lowerPricetextController.text = '';
      upperPricetextController.text = '';
    }

    final updatedFilter = filter.copyWith(
      lowerPrice: lowerPricetextController.text.isEmpty
          ? null
          : removePriceSeparators(lowerPricetextController.text),
      upperPrice: upperPricetextController.text.isEmpty
          ? null
          : removePriceSeparators(upperPricetextController.text),
    );
    final isFilterChanged = filter.toJson() != updatedFilter.toJson();

    context.read<FilterBloc>().add(SetFilter(updatedFilter));
    Navigator.of(context).pop(isFilterChanged);
  }
}
