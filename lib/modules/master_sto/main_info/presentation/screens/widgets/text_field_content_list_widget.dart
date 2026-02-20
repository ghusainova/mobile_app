import 'package:flutter/material.dart';

import '../../../../../../components/widgets/text_field_widget.dart';
import '../../../data/constants/main_info_constants.dart';
import '../../../data/enum/main_info_param_enum.dart';
import '../../../data/models/main_info.dart';

class TextFieldContentListWidget extends StatelessWidget {
  final MainInfo mainInfo;
  final void Function(MainInfoParamEnum param, String value) onChanged;

  const TextFieldContentListWidget({
    required this.mainInfo,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: MainInfoConstants.inputFields.map((config) {
        if (!mainInfo.toJson().containsKey(config.param.name)) {
          return const SizedBox();
        }

        return TextFieldWidget(
          margin: const EdgeInsets.only(top: 8),
          labelText: config.param.label,
          keyboardType: config.keyboardType,
          maxLength: config.maxLength,
          upperCaseFormatter: true,
          textController: TextEditingController(
            text: mainInfo.toJson()[config.param.name],
          ),
          onValidate: (value) =>
              _onValidate(value, config.maxLength, config.param.label),
          onTextChanged: (value) => onChanged(config.param, value),
        );
      }).toList(),
    );
  }

  String? _onValidate(String? value, int textLenght, String param) {
    final text = value ?? '';
    final isValidated = text.isEmpty || text.length != textLenght;

    if (isValidated) {
      return 'Введите ${param.toLowerCase()}';
    }

    return null;
  }
}
