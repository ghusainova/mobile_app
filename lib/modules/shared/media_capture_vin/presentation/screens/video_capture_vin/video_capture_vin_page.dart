import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../../../config/injectable/injectable.dart';
import '../../../../../../components/router/data/routes.dart';
import '../../../../../../components/widgets/appbar/appbar_widget.dart';
import '../../../../../../components/widgets/buttons/blue_button.dart';
import '../../../../../../components/widgets/snackbar/snackbar.dart';
import '../../../../../master_sto/history/domain/history/history_bloc.dart'
    as hb;
import '../../../../../master_sto/scan_cases/domain/scan_cases/scan_cases_bloc.dart'
    as sc;
import '../../../data/enum/media_capture_file_type_enum.dart';
import '../../../data/models/media_capture_route_args.dart';
import '../../../domain/media_capture_vin/media_capture_vin_bloc.dart';
import '../widgets/media_capture_btn_widget.dart';
import 'widgets/upload_error_widget.dart';
import 'widgets/video_capture_title_widget.dart';

class VideoCaptureVinPage extends StatefulWidget {
  final MediaCaptureRouteArgs args;

  const VideoCaptureVinPage(this.args, {super.key});

  @override
  State<VideoCaptureVinPage> createState() => _VideoCaptureVinPageState();
}

class _VideoCaptureVinPageState extends State<VideoCaptureVinPage> {
  final mediaBloc = getIt.get<MediaCaptureVinBloc>();
  final caseId = getIt.get<sc.ScanCasesBloc>().scanCase?.caseId;
  final title = 'Видео VIN-кода';
  XFile? mediaFile;

  @override
  void initState() {
    super.initState();
    initBloc();
  }

  @override
  void dispose() {
    mediaBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaWidgetSize = Size(
      MediaQuery.of(context).size.width / 2.1,
      MediaQuery.of(context).size.height / 8.53,
    );

    return Scaffold(
      appBar: AppBarWidget(
        title,
        onCloseBtnTap: () => const MasterStoRoute().go(context),
      ),
      body: RefreshIndicator(
        onRefresh: initBloc,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const VideoCaptureTitleWidget(),
            BlocProvider.value(
              value: mediaBloc,
              child: BlocConsumer<MediaCaptureVinBloc, MediaCaptureVinState>(
                listener: (context, state) => state.whenOrNull(
                  uploaded: onUploaded,
                  error: showMessage,
                ),
                builder: (context, state) => Column(
                  children: [
                    MediaCaptureBtnWidget(
                      url: mediaBloc.video?.filePath,
                      isLoading: state is Loading,
                      isVideo: true,
                      size: mediaWidgetSize,
                      margin: const EdgeInsets.only(top: 16),
                      onCaptured: onCaptured,
                      onDelete: onDelete,
                    ),
                    if (mediaFile != null && state is Error)
                      MediaUploadErrorWidget(() => onCaptured(mediaFile)),
                  ],
                ),
              ),
            ),
            BlueButton(
              margin: const EdgeInsets.only(top: 20),
              onPressed: onSubmit,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> initBloc() async {
    mediaBloc.add(
      GetMediaFiles(
        caseId: caseId,
        type: MediaTypeEnum.video.code,
      ),
    );
  }

  Future<void> onCaptured(XFile? file) async {
    if (file != null) {
      await saveTempFile(file);
      mediaBloc.add(
        UploadFile(
          caseId: caseId,
          type: MediaTypeEnum.video.code,
          file: File(file.path),
        ),
      );
    } else {
      showMessage('Произошла ошибка при сохранении видео, попробуйте снова');
    }
  }

  Future<void> saveTempFile(XFile file) async {
    final tempDir = await getApplicationDocumentsDirectory();
    final tempFile =
        await File(file.path).copy('${tempDir.path}/temp_${file.name}');
    setState(() => mediaFile = XFile(tempFile.path));
  }

  void onDelete() {
    final documentId = mediaBloc.video?.objectId;

    if (documentId != null) {
      setState(() => mediaFile = null);
      mediaBloc.add(
        DeleteFile(
          caseId: caseId,
          documentId: documentId,
          type: MediaTypeEnum.video.code,
        ),
      );
    } else {
      showMessage('Ошибка при удалении, обновите страницу');
    }
  }

  Future<void> onSubmit() async {
    if ((mediaBloc.video?.filePath ?? '').isEmpty) {
      showMessage('Загрузите видео');
      return;
    }

    if (mediaBloc.state is Loading) {
      showMessage(
        'Изображение загружается на сервер, файл может отобразиться не сразу',
      );
    }

    final isStageSaved = widget.args.saveHistoryStage
        ? await getIt.get<hb.HistoryBloc>().setOrderByName(title)
        : true;

    if (isStageSaved && mounted) {
      onUploaded(showSnack: false);
    } else {
      showMessage('Этап не сохранился, попробуйте еще раз');
    }
  }

  void onUploaded({bool showSnack = true}) {
    setState(() => mediaFile = null);

    if (showSnack) {
      showMessage('Видео загружено успешно!');
    }

    PhotoCaptureVinRoute(widget.args).push(context);
  }

  void showMessage(String? error) {
    showSnackBar(context, error);
  }
}
