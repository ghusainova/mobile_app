import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

void callToClient(String phone) {
  final url = Uri.parse('tel://+7$phone');
  launchUrl(url);
}

void copyIinToClipboard(String iin) {
  Clipboard.setData(ClipboardData(text: iin));
}
