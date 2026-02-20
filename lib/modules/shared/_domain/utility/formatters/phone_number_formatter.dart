import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

String formatPhoneNumber(String phone) {
  return MaskTextInputFormatter(
    mask: '+7 (###) ###-##-##',
    filter: {'#': RegExp(r'[0-9]')},
  ).maskText(phone);
}
