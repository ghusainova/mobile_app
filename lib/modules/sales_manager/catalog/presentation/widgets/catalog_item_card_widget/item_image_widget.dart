import 'package:flutter/material.dart';

import '../../../../../../components/widgets/cached_image_widget.dart';
import '../../../../../../components/widgets/parking_info.dart';
import '../../../data/models/parking.dart';

class ItemImageWidget extends StatelessWidget {
  final String? imageUrl;
  final Parking? parking;

  const ItemImageWidget({
    required this.imageUrl,
    super.key,
    this.parking,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: Column(
        children: [
          CachedImageWidget(
            imageUrl,
            width: 120,
            height: 92,
            borderRadius: 10,
          ),
          ParkingInfoWidget(
            parking,
            margin: const EdgeInsets.only(top: 12),
          ),
        ],
      ),
    );
  }
}
