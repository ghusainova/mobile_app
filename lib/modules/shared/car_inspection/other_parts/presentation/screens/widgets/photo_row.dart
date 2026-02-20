import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../config/injectable/injectable.dart';
import '../../../../../../../components/widgets/cached_image_widget.dart';
import '../../../../../../../components/widgets/snackbar/snackbar.dart';
import '../../../../../../sales_manager/auto_detail/data/enums/photo_type_enum.dart';
import '../../../../../../sales_manager/auto_detail/data/models/media_file_v1.dart';
import '../../../../../../sales_manager/auto_detail/domain/photos/photos_bloc.dart';

class PhotoRow extends StatefulWidget {
  final String? type;
  final String? orderId;

  const PhotoRow({
    super.key,
    this.type,
    this.orderId,
  });

  @override
  State<PhotoRow> createState() => _PhotoRowState();
}

class _PhotoRowState extends State<PhotoRow> {
  final photosBloc = getIt.get<PhotosBloc>();

  @override
  void initState() {
    super.initState();
    initBloc();
  }

  @override
  void dispose() {
    photosBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: photosBloc,
      child: BlocConsumer<PhotosBloc, PhotosState>(
        listener: (context, state) => state.whenOrNull(
          error: (message) => showSnackBar(context, message ?? ''),
        ),
        builder: (context, state) {
          final photos = state is Loaded ? state.photos : <MediaFileV1?>[];

          if (photos.isNotEmpty) {
            return Container(
              height: 120,
              margin: const EdgeInsets.symmetric(vertical: 16),
              child: ListView.builder(
                itemCount: photos.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () => openGalleryPhotoPreview(photos, index),
                  child: Container(
                    margin: const EdgeInsets.only(right: 8),
                    child: CachedImageWidget(
                      photos[index]?.s3Link,
                      width: 120,
                      height: 120,
                      borderRadius: 8,
                    ),
                  ),
                ),
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }

  void initBloc() {
    final type = PhotoTypeEnum.values
        .firstWhere((element) => element.label == widget.type)
        .documentType;

    photosBloc.add(
      PhotosEvent.load(orderId: widget.orderId, type: type),
    );
  }

  void openGalleryPhotoPreview(List<MediaFileV1?> photos, int index) {
    List<NetworkImage> networkImages = photos
        .where((photo) => photo?.s3Link != null)
        .map((photo) => NetworkImage(photo!.s3Link))
        .toList();

    MultiImageProvider multiImageProvider =
        MultiImageProvider(networkImages, initialIndex: index);
    showImageViewerPager(
      context,
      multiImageProvider,
    );
  }
}
