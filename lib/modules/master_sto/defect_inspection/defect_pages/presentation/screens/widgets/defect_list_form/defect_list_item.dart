import 'package:flutter/material.dart';

import '../../../../../_shared/data/models/defect_item.dart';

class DefectListItem extends StatelessWidget {
  final String title;
  final DefectItem defectItem;
  final VoidCallback onDelete;

  const DefectListItem({
    required this.title,
    required this.defectItem,
    required this.onDelete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      leading: _getLeading(context),
      title: Text(
        defectItem.name,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      trailing: IconButton(
        onPressed: onDelete,
        padding: EdgeInsets.zero,
        icon: const Icon(Icons.close),
      ),
    );
  }

  Widget? _getLeading(BuildContext context) {
    if (defectItem.name.isEmpty) {
      return null;
    }

    return CircleAvatar(
      radius: 13,
      backgroundColor: Colors.black,
      child: CircleAvatar(
        radius: 12,
        backgroundColor: Colors.white,
        child: Text(
          defectItem.name.substring(0, 1).toUpperCase(),
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
