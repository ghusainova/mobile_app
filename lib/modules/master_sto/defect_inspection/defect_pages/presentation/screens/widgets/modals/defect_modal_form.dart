import 'package:flutter/material.dart';

import '../../../../../../../../components/UI/checkbox_list/checkbox_list.dart';
import '../../../../../_shared/data/models/defect.dart';
import '../defect_list_form/defect_list_subtitle.dart';

class DefectModalForm extends StatelessWidget {
  final Defect defectList;
  final void Function(String title, String name, bool status) onChange;

  const DefectModalForm({
    required this.defectList,
    required this.onChange,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final options = defectList.values.map((e) => e.name).toList();
    List<String> selectedValues = List<String>.from(
      defectList.values
          .where((defectItem) => defectItem.status)
          .map((defectItem) => defectItem.name),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DefectListSubtitle(subtitle: defectList.title),
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
    onChange(defectList.title, name, status ?? false);
  }
}
