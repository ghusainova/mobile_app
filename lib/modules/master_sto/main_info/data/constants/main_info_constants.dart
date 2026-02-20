import 'package:flutter/material.dart';

import '../enum/main_info_param_enum.dart';
import '../models/input_field_config.dart';

class MainInfoConstants {
  static List<InputFieldConfig> inputFields = [
    InputFieldConfig(
      param: MainInfoParamEnum.year,
      keyboardType: TextInputType.number,
      maxLength: 4,
    ),
    InputFieldConfig(
      param: MainInfoParamEnum.stateNumber,
      keyboardType: TextInputType.text,
      maxLength: 15,
    ),
    InputFieldConfig(
      param: MainInfoParamEnum.vin,
      keyboardType: TextInputType.text,
      maxLength: 17,
    ),
    InputFieldConfig(
      param: MainInfoParamEnum.bodyNumber,
      keyboardType: TextInputType.text,
      maxLength: 17,
    ),
  ];
}
