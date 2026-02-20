import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../car_photo_inspection/data/models/photo_inspection_info_item.dart';
import '../../../../car_photo_inspection/presentation/screens/widgets/photo_inspection_card_widget.dart';

class SinglePhotoSelectionWidget extends StatelessWidget {
  final PhotoInspectionInfoItem infoItem;
  final void Function(int index) onDelete;
  final void Function(XFile? file) onCapture;

  const SinglePhotoSelectionWidget({
    required this.infoItem, required this.onDelete, required this.onCapture, super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PhotoInspectionCardWidget(
      info: infoItem,
      onDelete: _onDelete,
      onCapture: _onCapture,
    );
  }

  void _onDelete() {
    onDelete(0);
  }

  void _onCapture(XFile? file) {
    if (infoItem.iconPath.contains('http')) {
      _onDelete();
    }

    onCapture(file);
  }
}
