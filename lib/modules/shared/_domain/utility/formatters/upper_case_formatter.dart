import 'package:intl/intl.dart';

String toUpperCase(String? text) =>
    toBeginningOfSentenceCase((text ?? '').toLowerCase());
