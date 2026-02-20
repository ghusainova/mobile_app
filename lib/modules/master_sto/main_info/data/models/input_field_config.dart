import 'package:flutter/material.dart';

import '../enum/main_info_param_enum.dart';

class InputFieldConfig {
  final TextInputType keyboardType;
  final int maxLength;
  final MainInfoParamEnum param;

  InputFieldConfig({
    required this.keyboardType,
    required this.maxLength,
    required this.param,
  });
}
