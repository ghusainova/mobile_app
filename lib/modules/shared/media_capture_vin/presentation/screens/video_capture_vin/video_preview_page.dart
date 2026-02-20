import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../../../../../components/widgets/appbar/appbar_widget.dart';

class VideoPreviewPage extends StatefulWidget {
  final String videoUrl;

  const VideoPreviewPage(this.videoUrl, {super.key});

  @override
  State<VideoPreviewPage> createState() => _VideoPreviewPageState();
}

class _VideoPreviewPageState extends State<VideoPreviewPage> {
  VideoPlayerController? videoController;

  @override
  void initState() {
    super.initState();
    initVideoController();
  }

  @override
  void dispose() {
    videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget('Просмотр видео'),
      body: Center(
        child: videoController?.value.isInitialized == true
            ? AspectRatio(
                aspectRatio: videoController!.value.aspectRatio,
                child: VideoPlayer(videoController!),
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: playVideo,
        child: Icon(
          videoController?.value.isPlaying == true
              ? Icons.pause
              : Icons.play_arrow,
        ),
      ),
    );
  }

  Future<void> initVideoController() async {
    if (widget.videoUrl.isNotEmpty) {
      final url = Uri.parse(widget.videoUrl);
      videoController = VideoPlayerController.networkUrl(url);
    }

    if (videoController != null) {
      videoController!.initialize().then((value) => setState(() {}));
    }
  }

  Future<void> playVideo() async {
    if (videoController != null) {
      setState(() {
        if (videoController!.value.isPlaying) {
          videoController!.pause();
        } else {
          videoController!.play();
        }
      });
    }
  }
}
