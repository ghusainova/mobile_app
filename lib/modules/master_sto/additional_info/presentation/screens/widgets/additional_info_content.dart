import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../components/widgets/buttons/blue_button.dart';
import '../../../../../../components/widgets/snackbar/snackbar.dart';
import '../../../../../../components/widgets/text_field_read_only.dart';
import 'single_choice_lov_modal.dart';
import '../../../../../shared/additional_info/data/constans/additional_info_const.dart';
import '../../../../../shared/additional_info/data/enums/additional_info_param_enum.dart';
import '../../../data/models/additional_info.dart';

class AdditionalInfoContent extends StatelessWidget {
  final AdditionalInfo additionalInfo;
  final List<String> engineVolumes;
  final bool isLoading;
  final void Function() onSave;
  final void Function(AdditionalInfoParamEnum param, String value) onChangeInfo;

  const AdditionalInfoContent({
    required this.additionalInfo,
    required this.engineVolumes,
    required this.onSave,
    required this.onChangeInfo,
    required this.isLoading,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
            'Заполните дополнительную информацию об авто',
            style: Theme.of(context).textTheme.displayMedium,
          ),
        ),
        ...AdditionalInfoConstants.masterParamList.map(
          (config) {
            if (!additionalInfo.toJson().containsKey(config.param.name)) {
              return const SizedBox();
            }
            return TextFieldReadOnly(
              initialText: additionalInfo.toJson()[config.param.name],
              labelText: config.param.label,
              onValidate: (value) => _onValidate(value, config.param.label),
              onTap: () => _openModal(context, config),
            );
          },
        ),
        BlueButton(
          isLoading: isLoading,
          margin: const EdgeInsets.fromLTRB(0, 16, 0, 42),
          onPressed: () => _saveAndContinue(context),
        ),
      ],
    );
  }

  void _openModal(BuildContext context, FieldConfig config) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
      context: context,
      isScrollControlled: true,
      builder: (_) => SingleChoiceLovModal(
        title: config.param.label,
        initialValue: additionalInfo.toJson()[config.param.name],
        options: config.lov ?? engineVolumes,
        onConfirm: (selectedValue) =>
            _changeInfo(context, selectedValue, config),
      ),
    );
  }

  void _changeInfo(
    BuildContext context,
    String? selectedValue,
    FieldConfig config,
  ) {
    onChangeInfo(config.param, selectedValue ?? '');
    context.pop();
  }

  String? _onValidate(String? value, String param) {
    if ((value ?? '').isEmpty) {
      return 'Введите ${param.toLowerCase()}';
    }

    return null;
  }

  void _saveAndContinue(BuildContext context) {
    if (additionalInfo.isAnyFieldEmpty) {
      showSnackBar(context, 'Заполните все поля');
    } else {
      onSave();
    }
  }
}
