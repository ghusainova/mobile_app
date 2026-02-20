import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../../components/widgets/appbar/appbar_widget.dart';
import '../../../../../components/widgets/buttons/blue_button.dart';
import '../../../../../components/widgets/snackbar/snackbar.dart';
import '../../../../../config/injectable/injectable.dart';
import '../../../../shared/media_capture_vin/presentation/screens/video_capture_vin/widgets/upload_error_widget.dart';
import '../../../../shared/media_capture_vin/presentation/screens/video_capture_vin/widgets/video_capture_title_widget.dart';
import '../../../../shared/media_capture_vin/presentation/screens/widgets/media_capture_btn_widget.dart';
import '../../../credit_application/domain/credit_application/credit_application_bloc.dart'
    as acl;
import '../../data/enums/vin_credit_media_file_type_enum.dart';
import '../../data/models/credit_media_capture_route_args.dart';
import '../../domain/bloc/credit_media_capture_bloc.dart';

class CreditVideoCaptureVinPage extends StatefulWidget {
  final CreditMediaCaptureRouteArgs args;

  const CreditVideoCaptureVinPage(this.args, {super.key});

  @override
  State<CreditVideoCaptureVinPage> createState() =>
      _CreditVideoCaptureVinPageState();
}

class _CreditVideoCaptureVinPageState extends State<CreditVideoCaptureVinPage> {
  final mediaBloc = getIt.get<CreditMediaCaptureBloc>();
  final orderId = getIt.get<acl.CreditApplicationBloc>().orderId;
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
      appBar: const AppBarWidget(
        'Видео VIN-кода',
      ),
      body: RefreshIndicator(
        onRefresh: initBloc,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const VideoCaptureTitleWidget(),
            BlocProvider.value(
              value: mediaBloc,
              child:
                  BlocConsumer<CreditMediaCaptureBloc, CreditMediaCaptureState>(
                listener: (context, state) => state.whenOrNull(
                  uploaded: onUploaded,
                  error: showMessage,
                ),
                builder: (context, state) => Column(
                  children: [
                    MediaCaptureBtnWidget(
                      url: mediaBloc.video?.fileLink,
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
        orderId: orderId,
        fileType: VinCreditMediaFileTypeEnum.video.fileType,
        category: VinCreditMediaFileTypeEnum.video.category,
      ),
    );
  }

  Future<void> onCaptured(XFile? file) async {
    if (file != null) {
      await saveTempFile(file);
      mediaBloc.add(
        UploadFile(
          orderId: orderId,
          fileType: VinCreditMediaFileTypeEnum.video.fileType,
          category: VinCreditMediaFileTypeEnum.video.category,
          isVideo: true,
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
    final fileId = mediaBloc.video?.id;

    if (fileId != null) {
      setState(() => mediaFile = null);
      mediaBloc.add(
        DeleteFile(
          fileId: fileId,
          orderId: orderId,
          fileType: VinCreditMediaFileTypeEnum.video.fileType,
          category: VinCreditMediaFileTypeEnum.video.category,
        ),
      );
    } else {
      showMessage('Ошибка при удалении, обновите страницу');
    }
  }

  Future<void> onSubmit() async {
    if ((mediaBloc.video?.fileLink ?? '').isEmpty) {
      showMessage('Загрузите видео');
      return;
    }

    if (mediaBloc.state is Loading) {
      showMessage(
        'Изображение загружается на сервер, файл может отобразиться не сразу',
      );
      return;
    }

    if (mediaBloc.video != null) {
      widget.args.onFinalRoute();
    }
  }

  void onUploaded({bool showSnack = true}) {
    setState(() => mediaFile = null);

    if (showSnack) {
      showMessage('Видео загружено успешно!');
    }

    widget.args.onFinalRoute();
  }

  void showMessage(String? error) {
    showSnackBar(context, error);
  }
}
