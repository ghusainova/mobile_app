import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../config/injectable/injectable.dart';
import '../../../../../../../components/widgets/card_widget/card_widget.dart';
import '../../../../../../../components/widgets/snackbar/snackbar.dart';
import '../../../../../../shared/car_inspection/equipment/domain/equipment/equipment_bloc.dart';
import '../../../../domain/auto_detail/auto_detail_bloc.dart';
import 'equipment_item_list.dart';

class EquipmentForm extends StatefulWidget {
  const EquipmentForm({super.key});

  @override
  State<EquipmentForm> createState() => _EquipmentFormState();
}

class _EquipmentFormState extends State<EquipmentForm> {
  @override
  void initState() {
    super.initState();
    initBloc();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt.get<EquipmentBloc>(),
      child: BlocConsumer<EquipmentBloc, EquipmentState>(
        listener: (context, state) {
          state.whenOrNull(
            error: (message) => showSnackBar(context, message ?? ''),
            noContent: () => showSnackBar(
              context,
              'Отсутствуют данные об опциях и оборудовании',
            ),
          );
        },
        builder: (context, state) =>
            state.whenOrNull(
              hasContent: (equipment) {
                return CardWidget(
                  title: 'Опции и оборудование',
                  margin: const EdgeInsets.only(bottom: 16),
                  child: EquipmentItemList(equipmentMap: equipment!),
                );
              },
            ) ??
            const SizedBox(),
      ),
    );
  }

  void initBloc() {
    final autoInfo = context.read<AutoDetailBloc>().autoInfo;

    if (autoInfo != null) {
      getIt.get<EquipmentBloc>().add(EquipmentEvent.load(autoInfo: autoInfo));
    }
  }
}
