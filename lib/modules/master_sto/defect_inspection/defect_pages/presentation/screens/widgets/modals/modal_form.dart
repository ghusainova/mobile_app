import 'package:flutter/material.dart';

import '../../../../../../../../components/UI/checkbox_list/checkbox_list.dart';
import '../../../../../_shared/data/models/defect.dart';
import '../defect_list_form/defect_list_subtitle.dart';

class DefectModalForm extends StatelessWidget {
  final Defect defect;
  final void Function(Defect updatedDefect) onChange;

  const DefectModalForm({
    required this.defect,
    required this.onChange,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final options = defect.values.map((e) => e.name).toList();
    final selectedValues = defect.values
        .where((defectItem) => defectItem.status)
        .map((defectItem) => defectItem.name)
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DefectListSubtitle(subtitle: defect.title),
        Container(
          constraints: BoxConstraints(minHeight: options.length * 55),
          child: CheckboxList(
            selectedValues: selectedValues,
            values: options,
            onChange: _onChange,
          ),
        ),
      ],
    );
  }

  void _onChange(String name, bool? status) {
    final updatedValues = defect.values
        .map((e) => e.name == name ? e.copyWith(status: status ?? false) : e)
        .toList();
    final updatedDefect = defect.copyWith(values: updatedValues);
    onChange(updatedDefect);
  }
}
