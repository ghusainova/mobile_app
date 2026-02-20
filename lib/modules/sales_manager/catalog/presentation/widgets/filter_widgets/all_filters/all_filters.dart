import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/models/chip_form_info.dart';
import '../../../../../../../config/injectable/injectable.dart';
import '../../../../data/constants/filter_constants.dart';
import '../../../../../../shared/_data/constants/global_constants.dart';
import '../../../../../../../components/styles/app_colors.dart';
import '../../../../../../../components/widgets/buttons/buttons_bar.dart';
import '../../../../../../../components/widgets/card_widget/card_border_type_enum.dart';
import '../../../../../../../components/widgets/card_widget/card_widget.dart';
import '../../../../../../../components/UI/modal_appbar.dart';
import '../../../../domain/filter_bloc/filter_bloc.dart';
import 'chip_form.dart';
import 'filter_input.dart';
import 'nested_modal.dart';

class AllFilters extends StatelessWidget {
  const AllFilters({super.key});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.9,
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: AppColors.lightGray,
          borderRadius: BorderRadius.circular(24),
        ),
        child: BlocProvider.value(
          value: getIt.get<FilterBloc>(),
          child: Column(
            children: [
              const CardWidget(
                borderRadius: CardBorderTypeEnum.none,
                child: ModalAppBar(text: 'Фильтры'),
              ),
              Expanded(
                child: ListView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  children: [
                    const NestedModal(type: Constants.brandModel),
                    ...filters.map(
                      (e) => e is ChipFormInfo
                          ? FilterChipForm(chipFormInfo: e)
                          : FilteredTextFieldForm(filterInfo: e),
                    ),
                    const NestedModal(type: Constants.engineVolume),
                    const NestedModal(type: Constants.color),
                  ],
                ),
              ),
              CardWidget(
                shadow: true,
                borderRadius: CardBorderTypeEnum.onlyTop,
                child: ButtonsBar(
                  onClear: () => _onClear(context),
                  onConfirm: () => _onConfirm(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onClear(BuildContext context) {
    getIt.get<FilterBloc>().add(const ClearFilter());
    Navigator.of(context).pop();
  }

  void _onConfirm(BuildContext context) {
    getIt.get<FilterBloc>().add(const GetFilteredData());
    Navigator.of(context).pop();
  }
}
