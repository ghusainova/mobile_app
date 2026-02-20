import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../car_photo_inspection/data/models/photo_inspection_info_item.dart';
import '../../../../../shared/car_photo_inspection/presentation/screens/widgets/photo_inspection_card_widget.dart';
import 'media_capture_btn_widget.dart';

class VinPhotoForm extends StatelessWidget {
  final List<PhotoInspectionInfoItem> infoItems;
  final bool isLoading;
  final void Function(XFile? file) onCapture;
  final void Function(int index) onDelete;

  const VinPhotoForm({
    super.key,
    required this.infoItems,
    required this.isLoading,
    required this.onCapture,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (isLoading)
          Container(
            height: 4,
            margin: const EdgeInsets.only(top: 16),
            child: const LinearProgressIndicator(),
          ),
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(vertical: 16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisExtent: 120,
            mainAxisSpacing: 16,
            crossAxisCount: 2,
            crossAxisSpacing: 8,
          ),
          itemCount: infoItems.length + 1,
          itemBuilder: (context, index) {
            final currentIndex = index > 0 ? index - 1 : index;

            if (index == 0) {
              return MediaCaptureBtnWidget(
                size: Size.infinite,
                margin: const EdgeInsets.only(top: 9, right: 9),
                onCaptured: onCapture,
              );
            }

            return PhotoInspectionCardWidget(
              info: infoItems[currentIndex],
              cacheSize: Size.infinite,
              onDelete: () => onDelete(currentIndex),
            );
          },
        ),
      ],
    );
  }
}
