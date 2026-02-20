import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../../shared/car_photo_inspection/data/models/photo_inspection_info_item.dart';
import '../../../../../../../shared/car_photo_inspection/presentation/screens/widgets/photo_inspection_card_widget.dart';
import '../../../../../../../shared/media_capture_vin/presentation/screens/widgets/media_capture_btn_widget.dart';

class DefectsPhotoForm extends StatelessWidget {
  final bool pickGallery;
  final List<PhotoInspectionInfoItem> infoItems;
  final Size? cacheSize;
  final void Function(XFile? file) onCapture;
  final void Function(int index) onDelete;

  const DefectsPhotoForm({
    required this.infoItems, required this.onCapture, required this.onDelete, super.key,
    this.cacheSize,
    this.pickGallery = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(top: 16),
          child: Text(
            'Добавьте фото дефектов',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        Container(
          height: 90,
          margin: const EdgeInsets.only(top: 16),
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: infoItems.length + 1,
            itemBuilder: (context, index) {
              final currentIndex = index - 1;
              if (index == 0) {
                return MediaCaptureBtnWidget(
                  size: const Size(70, 70),
                  margin: const EdgeInsets.only(right: 16),
                  onCaptured: onCapture,
                  pickGallery: pickGallery,
                );
              }
              final item = infoItems[currentIndex];
              return Padding(
                padding: const EdgeInsets.only(bottom: 10, right: 8),
                child: PhotoInspectionCardWidget(
                  info: item,
                  cacheSize: cacheSize,
                  width: 70,
                  onDelete: () => onDelete(currentIndex),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
