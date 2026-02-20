import 'package:flutter/material.dart';

import '../../../../../_shared/data/models/defect.dart';
import '../../../../../_shared/data/models/defect_item.dart';
import 'defect_list_item.dart';
import 'defect_list_subtitle.dart';

class DefectListContent extends StatelessWidget {
  final Defect defect;
  final void Function(Defect) onDelete;

  const DefectListContent({
    required this.defect,
    required this.onDelete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final allDefects = defect.values;
    final selectedDefects =
        allDefects.where((defectItem) => defectItem.status).toList();

    if (selectedDefects.isEmpty) {
      return const SizedBox();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DefectListSubtitle(subtitle: defect.title),
        Container(
          constraints: BoxConstraints(minHeight: selectedDefects.length * 68),
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: selectedDefects.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) => DefectListItem(
              title: defect.title,
              defectItem: selectedDefects[index],
              onDelete: () => _onDelete(selectedDefects[index]),
            ),
          ),
        ),
      ],
    );
  }

  void _onDelete(DefectItem defectItem) {
    final updatedDefectItems = defect.values
        .map(
          (e) => e.name == defectItem.name
              ? defectItem.copyWith(status: false)
              : e,
        )
        .toList();
    final updatedDefect = defect.copyWith(values: updatedDefectItems);
    onDelete(updatedDefect);
  }
}
