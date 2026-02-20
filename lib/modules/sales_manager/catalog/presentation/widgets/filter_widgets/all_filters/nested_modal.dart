import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../config/injectable/injectable.dart';
import '../../../../../../shared/_data/constants/global_constants.dart';
import '../../../../../../../components/styles/app_colors.dart';
import '../../../../../../../components/widgets/card_widget/card_border_type_enum.dart';
import '../../../../../../../components/widgets/card_widget/card_widget.dart';
import '../../../../domain/filter_bloc/filter_bloc.dart';
import '../modals/filter_modal.dart';
import 'chip_form.dart';

class NestedModal extends StatefulWidget {
  final String type;

  const NestedModal({required this.type, super.key});

  @override
  State<NestedModal> createState() => _NestedModalState();
}

class _NestedModalState extends State<NestedModal> {
  @override
  Widget build(BuildContext context) {
    return CardWidget(
      margin: const EdgeInsets.only(bottom: 12),
      borderRadius: widget.type == Constants.brandModel
          ? CardBorderTypeEnum.onlyBottom
          : CardBorderTypeEnum.all,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FormTitle(title: widget.type, context: context),
          const SizedBox(height: 24),
          _body(context),
        ],
      ),
    );
  }

  Widget _body(context) {
    return BlocBuilder<FilterBloc, FilterState>(
      builder: (context, state) {
        return TextField(
          readOnly: true,
          controller: TextEditingController(
            text: _getValue(widget.type) ?? widget.type,
          ),
          decoration: InputDecoration(
            hintText: widget.type,
            filled: true,
            fillColor: AppColors.lightGray,
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide.none,
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            suffixIcon: const Icon(
              Icons.chevron_right,
              color: Colors.grey,
            ),
          ),
          onTap: () => openFilterModal(context, widget.type),
        );
      },
    );
  }

  String? _getValue(String type) {
    final filter = getIt.get<FilterBloc>().currentFilter;

    switch (type) {
      case 'Марка/Модель':
        if (filter.brand == null || filter.model == null) {
          return null;
        }
        return '${filter.brand ?? ''} ${filter.model ?? []}';
      case 'Объем двигателя':
        return filter.engineVolume?.join(', ');
      case 'Цвет':
        return filter.color?.join(', ');
      default:
        break;
    }

    return null;
  }
}
