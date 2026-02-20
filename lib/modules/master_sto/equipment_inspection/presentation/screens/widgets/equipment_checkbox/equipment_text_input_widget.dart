import 'package:flutter/material.dart';

import '../../../../../../../components/widgets/buttons/icon_button_widget.dart';
import '../../../../../../../components/widgets/text_field_widget.dart';
import '../../../../data/models/inspection_item/inspection_value/inspection_value.dart';

class EquipmentTextInputWidget extends StatefulWidget {
  final InspectionValue value;
  final String? labelText;
  final bool readOnly;
  final bool digitsOnly;
  final bool autofocus;
  final bool forceUpdateTextValue;
  final VoidCallback? onTap;
  final void Function(String? text)? onChange;

  const EquipmentTextInputWidget({
    required this.value,
    super.key,
    this.labelText,
    this.readOnly = false,
    this.digitsOnly = true,
    this.autofocus = false,
    this.forceUpdateTextValue = true,
    this.onTap,
    this.onChange,
  });

  @override
  State<EquipmentTextInputWidget> createState() =>
      _EquipmentTextInputWidgetState();
}

class _EquipmentTextInputWidgetState extends State<EquipmentTextInputWidget> {
  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    mapTextToController();
  }

  @override
  void didUpdateWidget(covariant EquipmentTextInputWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    mapTextToController(force: widget.forceUpdateTextValue);
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFieldWidget(
      autofocus: widget.autofocus,
      textController: textController,
      labelText: widget.labelText,
      digitsOnly: widget.digitsOnly,
      readOnly: widget.readOnly,
      suffixIcon: widget.readOnly
          ? null
          : IconButtonWidget(
              icon: const Icon(Icons.close),
              onTap: onClear,
            ),
      keyboardType: TextInputType.number,
      onTap: widget.onTap,
      onValidate: onValidate,
      onTextChanged: widget.onChange,
    );
  }

  void mapTextToController({bool force = true}) {
    if (force) {
      textController.text = widget.value.subValues.isNotEmpty
          ? widget.value.subValues.first.name
          : '';
    }
  }

  void onClear() {
    textController.text = '';

    if (widget.onChange != null) {
      widget.onChange!(null);
    }
  }

  String? onValidate(String? text) {
    if ((text ?? '').isEmpty) {
      return 'Введите значение';
    }

    return null;
  }
}
