import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../../../components/widgets/buttons/buttons_bar.dart';
import '../../../../../../../../components/widgets/switch_list_tile.dart';
import '../../../../../../../../components/UI/modal_appbar.dart';
import '../../../../../data/models/inspection_item/inspection_value/inspection_subvalue.dart';
import '../../../../../data/models/inspection_item/inspection_value/inspection_value.dart';
import '../../../widgets/equipment_checkbox/equipment_text_input_widget.dart';

class CompressionModal extends StatefulWidget {
  final InspectionValue value;
  final void Function(InspectionValue updatedValue) onChange;

  const CompressionModal({
    required this.value,
    required this.onChange,
    super.key,
  });

  @override
  State<CompressionModal> createState() => _CompressionModalState();
}

class _CompressionModalState extends State<CompressionModal> {
  final noCompressionTitle = 'Нет возможности замерить компрессию';
  bool noCompression = false;
  late InspectionValue value;

  @override
  void initState() {
    super.initState();
    initFields();
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.65,
      child: ListView(
        padding: const EdgeInsets.all(16).copyWith(top: 8),
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: ModalAppBar(text: 'Замер компрессии'),
          ),
          EquipmentTextInputWidget(
            value: value,
            labelText: '${value.name}, кг/см2',
            digitsOnly: false,
            autofocus: true,
            forceUpdateTextValue: true,
            onChange: onChange,
          ),
          AppSwitchListTile(
            text: noCompressionTitle,
            switchValue: noCompression,
            onChanged: onSwitch,
          ),
          ButtonsBar(
            onClear: () => onChange(null),
            onConfirm: onSubmit,
          ),
        ],
      ),
    );
  }

  void initFields() {
    noCompression = widget.value.subValues.isNotEmpty &&
            widget.value.subValues.first.name == noCompressionTitle
        ? true
        : false;
    value = widget.value;
  }

  void onSwitch(bool value) {
    setState(() => noCompression = value);
    onChange(noCompression ? noCompressionTitle : null);
  }

  void onChange(String? text, {bool submit = false}) {
    List<InspectionSubvalue> subValues = [];

    if ((text ?? '').isNotEmpty) {
      subValues = [InspectionSubvalue(name: text!, selected: true)];
    } else {
      subValues = [];
    }

    setState(
      () => value = value.copyWith(
        selected: subValues.isNotEmpty,
        subValues: subValues,
      ),
    );

    if (submit) onSubmit();
  }

  void onSubmit() {
    widget.onChange(value);
    context.pop();
  }
}
