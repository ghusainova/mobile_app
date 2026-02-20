import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../components/widgets/buttons/outlined_blue_button.dart';

class CameraNavBtnWidget extends StatefulWidget {
  final bool hideBtn;
  final bool isVideoRecording;
  final bool hasMediaFile;
  final bool forceOpenCamera;
  final bool isLoading;
  final void Function(XFile? path) onCaptured;

  const CameraNavBtnWidget({
    required this.hideBtn,
    required this.onCaptured,
    super.key,
    this.isVideoRecording = false,
    this.hasMediaFile = false,
    this.forceOpenCamera = false,
    this.isLoading = false,
  });

  @override
  State<CameraNavBtnWidget> createState() => _CameraNavBtnWidgetState();
}

class _CameraNavBtnWidgetState extends State<CameraNavBtnWidget> {
  @override
  void initState() {
    super.initState();
    forceOpenCamera();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.hideBtn) {
      return const SizedBox();
    }

    return OutlinedBlueButton(
      text: getBtnTitle(),
      slim: true,
      isLoading: widget.isLoading,
      onPressed: navigateToCamera,
    );
  }

  void forceOpenCamera() {
    if (widget.forceOpenCamera) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await navigateToCamera();
      });
    }
  }

  String getBtnTitle() {
    if (widget.isVideoRecording) {
      return widget.hasMediaFile ? 'Перезаписать видео' : 'Записать видео';
    }

    return widget.hasMediaFile ? 'Переснять фото' : 'Сделать фото';
  }

  Future<void> navigateToCamera() async {
    final picker = ImagePicker();
    XFile? response;

    if (widget.isVideoRecording) {
      response = await picker.pickVideo(
        source: ImageSource.camera,
        maxDuration: const Duration(minutes: 1),
      );
    } else {
      response = await picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 30,
      );
    }

    widget.onCaptured(response);
  }
}
