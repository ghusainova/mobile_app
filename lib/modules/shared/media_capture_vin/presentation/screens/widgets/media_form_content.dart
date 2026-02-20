import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../master_sto/defect_inspection/defect_pages/presentation/screens/widgets/defect_list_form/defect_photo.dart';
import '../../../../car_photo_inspection/data/models/photo_inspection_info_item.dart';
import '../../../data/enum/media_capture_file_type_enum.dart';
import '../../../data/models/media_file.dart';
import 'photo_grid_view_widget.dart';

class MediaFormContent extends StatefulWidget {
  final List<MediaFile> mediaFiles;
  final String documentType;
  final bool pickGallery;
  final bool isLoading;
  final Size? cacheSize;
  final void Function(int index) onDelete;
  final void Function(XFile? file) onCapture;

  const MediaFormContent({
    required this.mediaFiles,
    required this.documentType,
    required this.onDelete,
    required this.onCapture,
    super.key,
    this.pickGallery = false,
    this.isLoading = false,
    this.cacheSize,
  });

  @override
  State<MediaFormContent> createState() => _MediaFormContentState();
}

class _MediaFormContentState extends State<MediaFormContent> {
  List<PhotoInspectionInfoItem> infoItems = [];

  @override
  void didUpdateWidget(MediaFormContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.mediaFiles != widget.mediaFiles) {
      addItemToList();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.documentType == MediaTypeEnum.photo.code) {
      return VinPhotoForm(
        infoItems: infoItems,
        isLoading: widget.isLoading,
        onCapture: widget.onCapture,
        onDelete: widget.onDelete,
      );
    }

    return DefectsPhotoForm(
      infoItems: infoItems,
      onCapture: widget.onCapture,
      cacheSize: widget.cacheSize,
      onDelete: widget.onDelete,
      pickGallery: widget.pickGallery,
    );
  }

  void addItemToList() {
    infoItems = widget.mediaFiles
        .map(
          (e) =>
              PhotoInspectionInfoItem(iconPath: e.filePath, isAdditional: true),
        )
        .toList();
  }
}
