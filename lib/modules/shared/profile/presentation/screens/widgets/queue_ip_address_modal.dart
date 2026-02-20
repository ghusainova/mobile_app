import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../components/UI/modal_appbar.dart';
import '../../../../../../components/widgets/buttons/buttons_bar.dart';
import '../../../../../../components/widgets/snackbar/snackbar.dart';
import '../../../../../../components/widgets/text_field_widget.dart';

class QueueIpAddressModal extends StatefulWidget {
  final String? ip;

  const QueueIpAddressModal(this.ip, {super.key});

  @override
  State<QueueIpAddressModal> createState() => _QueueIpAddressModalState();
}

class _QueueIpAddressModalState extends State<QueueIpAddressModal> {
  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    textController.text = widget.ip ?? '';
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.8,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ModalAppBar(text: 'IP адрес электронной очереди'),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Text(
                'Введите IP адрес присвоенный устройству для взаимодействия с электронной очередью.\nПо вопросам получения IP адреса, обращайтесь в тех-поддержку.',
              ),
            ),
            TextFieldWidget(
              textController: textController,
              margin: const EdgeInsets.symmetric(vertical: 24),
              autofocus: true,
              keyboardType: TextInputType.number,
              onValidate: onValidate,
            ),
            ButtonsBar(
              onClear: onCancel,
              onConfirm: onSubmit,
              submitBtnLabel: 'Сохранить',
            ),
          ],
        ),
      ),
    );
  }

  String? onValidate(String? text) {
    const errorText = 'Введите корректный IP адрес';

    if ((text ?? '').isEmpty) {
      return errorText;
    }

    try {
      Uri.parseIPv4Address(text!);
    } on FormatException {
      return errorText;
    }

    return null;
  }

  void onCancel() {
    textController.clear();
  }

  void onSubmit() async {
    final errorText = onValidate(textController.text);

    if ((errorText ?? '').isNotEmpty) {
      showSnackBar(context, errorText);
      return;
    }

    if (mounted) context.pop(textController.text);
  }
}
