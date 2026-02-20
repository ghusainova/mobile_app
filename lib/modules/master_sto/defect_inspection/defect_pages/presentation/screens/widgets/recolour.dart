import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../components/widgets/card_widget/card_widget.dart';
import '../../../../../../../components/widgets/switch_list_tile.dart';
import '../../../../../../../components/widgets/text_field_widget.dart';
import '../../../domain/defects/defects_bloc.dart';

class Recolour extends StatefulWidget {
  const Recolour({super.key});

  @override
  State<Recolour> createState() => _RecolourState();
}

class _RecolourState extends State<Recolour> {
  final textController = TextEditingController();
  bool mileageSwitcher = false;

  @override
  void initState() {
    super.initState();
    mapData();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      margin: const EdgeInsets.only(top: 16),
      boxPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      child: Column(
        children: [
          AppSwitchListTile(
            text: 'Вся деталь повторно окрашена',
            margin: const EdgeInsets.symmetric(horizontal: 16),
            switchValue: mileageSwitcher,
            onChanged: onChangeRecolour,
          ),
          Visibility(
            visible: mileageSwitcher,
            child: TextFieldWidget(
              noFilling: true,
              digitsOnly: true,
              textController: textController,
              labelText: 'Средняя толщина краски *',
              keyboardType: TextInputType.number,
              onTextChanged: onChangeAveragePaint,
            ),
          ),
        ],
      ),
    );
  }

  void mapData() {
    final bloc = context.read<DefectsBloc>();
    mileageSwitcher = bloc.defect.recolouring;
    textController.text = bloc.defect.averagePaintThickness;
  }

  void onChangeRecolour(bool value) {
    final bloc = context.read<DefectsBloc>();
    final newDefect = value
        ? bloc.defect.copyWith(recolouring: value)
        : bloc.defect.copyWith(recolouring: value, averagePaintThickness: '');

    setState(() => mileageSwitcher = value);
    bloc.add(DefectsEvent.setDefect(newDefect));
  }

  void onChangeAveragePaint(String value) {
    final bloc = context.read<DefectsBloc>();
    final newDefect = bloc.defect.copyWith(averagePaintThickness: value);
    bloc.add(DefectsEvent.setDefect(newDefect));
  }
}
