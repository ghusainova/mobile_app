import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../data/models/credit_photo_inspection_info_item.dart';
import '../photo_inspection/widgets/credit_photo_inspection_card_widget.dart';
import 'credit_vin_photo_form.dart';

class CreditMediaForm extends StatefulWidget {
  final List<CreditPhotoInspectionInfoItem>? inspectionInfoItems;
  final CreditPhotoInspectionInfoItem? singleInfoItem;
  final bool isLoading;
  final void Function(int index) onDelete;
  final void Function(XFile? file) onCapture;

  const CreditMediaForm({
    super.key,
    required this.onDelete,
    required this.onCapture,
    this.inspectionInfoItems,
    this.singleInfoItem,
    this.isLoading = false,
  });

  @override
  State<CreditMediaForm> createState() => _CreditMediaFormState();
}

class _CreditMediaFormState extends State<CreditMediaForm> {
  @override
  Widget build(BuildContext context) {
    if (widget.singleInfoItem != null) {
      return CreditPhotoInspectionCardWidget(
        info: widget.singleInfoItem!,
        cacheSize: const Size(100, 100),
        isLoading: widget.isLoading,
        onDelete: () => widget.onDelete(0),
        onCapture: widget.onCapture,
      );
    }

    return CreditVinPhotoForm(
      infoItems: widget.inspectionInfoItems!,
      isLoading: widget.isLoading,
      onCapture: widget.onCapture,
      onDelete: (index) => widget.onDelete(index),
    );
  }
}
