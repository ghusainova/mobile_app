import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../sales_manager/auto_detail/data/models/media_file_v1.dart';
import '../../../../car_photo_inspection/data/models/photo_inspection_info_item.dart';
import 'single_photo_selection_widget.dart';

//TODO: remove this when media api will be refactored to v2/media
class BuyerMediaFormContent extends StatefulWidget {
  final List<MediaFileV1> mediaFiles;
  final PhotoInspectionInfoItem infoItem;
  final void Function(int index) onDelete;
  final void Function(XFile? file) onCapture;

  const BuyerMediaFormContent({
    required this.mediaFiles,
    required this.infoItem,
    required this.onDelete,
    required this.onCapture,
    super.key,
  });

  @override
  State<BuyerMediaFormContent> createState() => _BuyerMediaFormContentState();
}

class _BuyerMediaFormContentState extends State<BuyerMediaFormContent> {
  List<PhotoInspectionInfoItem> infoItems = [];
  PhotoInspectionInfoItem? singleInfoItem;

  @override
  void initState() {
    super.initState();
    singleInfoItem = widget.infoItem;
  }

  @override
  void didUpdateWidget(BuyerMediaFormContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.mediaFiles != widget.mediaFiles) {
      addItemToList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SinglePhotoSelectionWidget(
      infoItem: singleInfoItem!,
      onDelete: widget.onDelete,
      onCapture: widget.onCapture,
    );
  }

  void addItemToList() {
    if (singleInfoItem != null && widget.mediaFiles.isNotEmpty) {
      //TODO: remove this when media api will be refactored to v2/media
      singleInfoItem = PhotoInspectionInfoItem(
        title: singleInfoItem?.title ?? '',
        isAdditional: true,
        iconPath: widget.mediaFiles.first.s3Link,
      );
    }
  }
}
