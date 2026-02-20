import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../config/injectable/injectable.dart';
import '../../../../../../components/widgets/snackbar/snackbar.dart';
import '../../../../../master_sto/equipment_inspection/data/enum/inspection_item_enum.dart';
import '../../../../../master_sto/scan_cases/domain/scan_cases/scan_cases_bloc.dart'
    as sc;
import '../../../data/models/media_file.dart';
import '../../../domain/media_capture_vin/media_capture_vin_bloc.dart';
import 'media_form_content.dart';

class MediaForm extends StatefulWidget {
  final String? caseId;
  final String documentType;
  final String? subType;
  final Size? cacheSize;
  final VoidCallback? onLoading;
  final void Function(List<MediaFile> mediaFiles)? onLoaded;

  const MediaForm({
    required this.caseId,
    required this.documentType,
    super.key,
    this.subType,
    this.cacheSize,
    this.onLoading,
    this.onLoaded,
  });

  @override
  State<MediaForm> createState() => _MediaFormState();
}

class _MediaFormState extends State<MediaForm> {
  final mediaBloc = getIt.get<MediaCaptureVinBloc>();
  final scanCasesBloc = getIt.get<sc.ScanCasesBloc>();
  List<MediaFile> mediaFiles = [];

  bool get isParkingManager => scanCasesBloc.scanCase?.isParking ?? false;

  bool get isComputerDiagnosticsStage =>
      widget.documentType == InspectionItemEnum.computerDiagnostics.stageName;

  String get docType => isParkingManager && isComputerDiagnosticsStage
      ? 'Парковка ${widget.documentType}'
      : widget.documentType;

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
    if (isParkingManager && !isComputerDiagnosticsStage) {
      return const SizedBox();
    }

    return BlocProvider.value(
      value: mediaBloc,
      child: BlocConsumer<MediaCaptureVinBloc, MediaCaptureVinState>(
        listener: (context, state) => state.whenOrNull(
          loading: widget.onLoading,
          loaded: mapInfoItems,
          uploaded: () => showMessage(
            'Файл отправлен на загрузку',
          ),
          deleted: () => showMessage('Файл удален'),
          error: (error) => showMessage(error),
        ),
        builder: (context, state) {
          return MediaFormContent(
            mediaFiles: mediaFiles,
            documentType: docType,
            pickGallery: isComputerDiagnosticsStage,
            isLoading: state is Loading,
            cacheSize: widget.cacheSize,
            onDelete: onDelete,
            onCapture: onCapture,
          );
        },
      ),
    );
  }

  void initBloc() {
    mediaBloc.add(
      GetMediaFiles(
        caseId: widget.caseId,
        type: docType,
      ),
    );
  }

  void mapInfoItems(List<MediaFile> files) {
    if (widget.onLoaded != null) {
      widget.onLoaded!(files);
    }
    if (widget.subType != null) {
      mediaFiles = files
          .where((element) => element.documentType == widget.subType)
          .toList();
    } else {
      mediaFiles = files;
    }
  }

  void showMessage(String? message) {
    showSnackBar(context, message);
  }

  void onDelete(int index) {
    final photos = mediaBloc.photos(widget.subType ?? docType);

    if (photos.isNotEmpty) {
      final objectId = photos.length > index ? photos[index].objectId : null;

      if (objectId != null) {
        mediaBloc.add(
          DeleteFile(
            caseId: widget.caseId,
            documentId: objectId,
            type: docType,
            subType: widget.subType,
          ),
        );
      }
    }
  }

  void onCapture(XFile? file) {
    if (file != null) {
      final mediaFile = File(file.path);

      mediaBloc.add(
        UploadFile(
          caseId: widget.caseId,
          type: docType,
          subType: widget.subType,
          file: mediaFile,
        ),
      );
    }
  }
}
