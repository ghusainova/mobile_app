import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../components/styles/app_colors.dart';
import '../../../../../../../../components/widgets/cached_image_widget.dart';
import '../../../../../data/models/media_file_v1.dart';

class ImageCarousel extends StatefulWidget {
  final List<MediaFileV1?> photos;
  final bool showGallery;

  const ImageCarousel({
    required this.photos,
    super.key,
    this.showGallery = false,
  });

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  List<String> imageUrls = [];
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    imageUrls = widget.photos
        .where((el) => (el?.s3CompressLink ?? '').isNotEmpty)
        .map((e) => e!.s3CompressLink)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 270,
        aspectRatio: 16 / 9,
        viewportFraction: 1,
        initialPage: 0,
        enableInfiniteScroll: true,
        onPageChanged: (index, _) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
      items: widget.photos.isEmpty
          ? [const CachedImageWidget(null, width: double.infinity)]
          : widget.photos
              .asMap()
              .entries
              .map(
                (entry) => GestureDetector(
                  onTap: () => showGallery(entry.key),
                  child: Stack(
                    children: [
                      CachedImageWidget(
                        entry.value?.s3CompressLink,
                        width: double.infinity,
                        borderRadius: 0,
                      ),
                      Positioned(
                        bottom: 12,
                        right: 16,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 4,
                            horizontal: 8,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.transparentBlack,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            '${entry.key + 1}/${widget.photos.length}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
    );
  }

  void showGallery(int index) {
    if (widget.photos.isEmpty) {
      return;
    }

    final networkImages = widget.photos
        .where((photo) => (photo?.s3CompressLink ?? '').isNotEmpty)
        .map((photo) => NetworkImage(photo!.s3CompressLink))
        .toList();
    final multiImageProvider =
        MultiImageProvider(networkImages, initialIndex: index);

    showImageViewerPager(
      context,
      multiImageProvider,
      useSafeArea: true,
      infinitelyScrollable: true,
      doubleTapZoomable: true,
    );
  }
}
