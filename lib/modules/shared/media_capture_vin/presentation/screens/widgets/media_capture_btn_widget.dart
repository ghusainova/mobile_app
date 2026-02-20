import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:badges/badges.dart' as badges;

import '../../../../../../components/router/data/routes.dart';
import '../../../../../../components/styles/app_colors.dart';
import '../../../../../../components/widgets/snackbar/snackbar.dart';
import 'capture_btn_state_widget.dart';

class MediaCaptureBtnWidget extends StatefulWidget {
  final String? url;
  final bool isLoading;
  final bool isVideo;
  final bool pickGallery;
  final Size size;
  final EdgeInsets margin;
  final VoidCallback? onDelete;
  final void Function(XFile? video) onCaptured;

  const MediaCaptureBtnWidget({
    required this.size,
    required this.onCaptured,
    super.key,
    this.url,
    this.isLoading = false,
    this.isVideo = false,
    this.pickGallery = false,
    this.margin = EdgeInsets.zero,
    this.onDelete,
  });

  @override
  State<MediaCaptureBtnWidget> createState() => _MediaCaptureBtnWidgetState();
}

class _MediaCaptureBtnWidgetState extends State<MediaCaptureBtnWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      alignment: Alignment.centerLeft,
      child: badges.Badge(
        showBadge: !widget.isLoading && widget.isVideo,
        badgeContent: const Icon(Icons.close, color: Colors.white, size: 14),
        badgeStyle: const badges.BadgeStyle(badgeColor: AppColors.inactiveText),
        onTap: widget.onDelete,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: InkWell(
            onTap: onCapture,
            child: Container(
              width: widget.size.width,
              height: widget.size.height,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: widget.isVideo ? AppColors.backBase : null,
                border: Border.all(width: 1, color: AppColors.primaryBlue),
                borderRadius: BorderRadius.circular(8),
              ),
              child: MediaCaptureBtnStateWidget(
                small: widget.size.width < 80 ? true : false,
                isLoading: widget.isLoading,
                hasVideo: widget.isVideo && widget.url != null,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onCapture() async {
    XFile? media;

    if (widget.isLoading) {
      showSnackBar(context, 'Подождите, идет загрузка файла');
      return;
    } else if (widget.isVideo) {
      media = await recordVideo();
    } else if (widget.pickGallery) {
      cameraOrGalleryModal();
    } else {
      media = await capturePhoto(ImageSource.camera);
    }

    if (media != null && mounted) {
      widget.onCaptured(media);
    }
  }

  Future<XFile?> recordVideo() async {
    if (widget.url != null) {
      VideoPreviewRoute(widget.url!).push(context);
      return null;
    }

    return await ImagePicker().pickVideo(
      source: ImageSource.camera,
      maxDuration: const Duration(minutes: 1),
    );
  }

  void cameraOrGalleryModal() {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child: Text(
              'Галерея',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            onPressed: () {
              getImage(ImageSource.gallery, context);
            },
          ),
          CupertinoActionSheetAction(
            child: Text(
              'Камера',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            onPressed: () {
              getImage(ImageSource.camera, context);
            },
          ),
        ],
      ),
    );
  }

  Future<void> getImage(ImageSource source, BuildContext context) async {
    Navigator.of(context).pop();

    final media = await capturePhoto(source);

    if (media != null && mounted) {
      widget.onCaptured(media);
    }
  }

  Future<XFile?> capturePhoto(ImageSource source) async {
    return await ImagePicker().pickImage(
      source: source,
      imageQuality: 30,
    );
  }
}
