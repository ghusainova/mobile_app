import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../components/widgets/buttons/blue_button.dart';
import '../../../../../../components/widgets/snackbar/snackbar.dart';
import '../../../../../../components/widgets/text_field_read_only.dart';
import '../../../../../master_sto/additional_info/presentation/screens/widgets/single_choice_lov_modal.dart';
import '../../../../../shared/additional_info/data/constans/additional_info_const.dart';
import '../../../../../shared/additional_info/data/enums/additional_info_param_enum.dart';
import '../../../data/models/credit_additional_info.dart';

class CreditAdditionalInfoContent extends StatelessWidget {
  final CreditAdditionalInfo additionalInfo;
  final bool isLoading;
  final void Function() onSave;
  final void Function(AdditionalInfoParamEnum param, String value) onChangeInfo;

  const CreditAdditionalInfoContent({
    required this.additionalInfo,
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
        ...AdditionalInfoConstants.creditParamList.map(
          (config) {
            if (!additionalInfo.toJson().containsKey(config.param.name)) {
              return const SizedBox();
            }

            return TextFieldReadOnly(
              initialText: additionalInfo.toJson()[config.param.name],
              labelText: config.param.label,
              onValidate: (value) => _onValidate(value, config.param.label),
              onTap:
                  config.lov != null ? () => _openModal(context, config) : null,
            );
          },
        ),
        BlueButton(
          isLoading: isLoading,
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
      useSafeArea: true,
      builder: (_) => SingleChoiceLovModal(
        singleButton: true,
        title: config.param.label,
        initialValue: additionalInfo.toJson()[config.param.name],
        options: config.lov ?? [],
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
    if (context.mounted) context.pop();
    onChangeInfo(config.param, selectedValue ?? '');
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
