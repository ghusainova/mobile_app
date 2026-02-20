import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../config/injectable/injectable.dart';
import '../../../../../../components/widgets/snackbar/snackbar.dart';
import '../../../../../master_sto/scan_cases/domain/scan_cases/scan_cases_bloc.dart'
    as sc;
import '../../../../../sales_manager/auto_detail/data/models/media_file_v1.dart';
import '../../../../car_photo_inspection/data/models/photo_inspection_info_item.dart';
import '../../../domain/buyer_media_capture_vin/buyer_media_capture_vin_bloc.dart';
import 'buyer_media_form_content.dart';

//TODO: remove this widget when media api will be refactored to v2/media
class BuyerMediaForm extends StatefulWidget {
  final String? caseId;
  final String documentType;
  final String? subType;
  final Size? cacheSize;
  final PhotoInspectionInfoItem infoItem;
  final VoidCallback? onLoading;
  final void Function(List<MediaFileV1> mediaFiles)? onLoaded;

  const BuyerMediaForm({
    required this.caseId,
    required this.documentType,
    required this.infoItem,
    super.key,
    this.subType,
    this.cacheSize,
    this.onLoading,
    this.onLoaded,
  });

  @override
  State<BuyerMediaForm> createState() => _BuyerMediaFormState();
}

class _BuyerMediaFormState extends State<BuyerMediaForm> {
  final mediaBloc = getIt.get<BuyerMediaCaptureVinBloc>();
  final scanCasesBloc = getIt.get<sc.ScanCasesBloc>();
  List<MediaFileV1> mediaFiles = [];

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
    return BlocProvider.value(
      value: mediaBloc,
      child: BlocConsumer<BuyerMediaCaptureVinBloc, BuyerMediaCaptureVinState>(
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
          return BuyerMediaFormContent(
            mediaFiles: mediaFiles,
            infoItem: widget.infoItem,
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
        type: widget.documentType,
      ),
    );
  }

  void mapInfoItems(List<MediaFileV1> files) {
    if (widget.onLoaded != null) {
      widget.onLoaded!(files);
    }
    if (widget.subType != null) {
      mediaFiles =
          files.where((element) => element.type == widget.subType).toList();
    } else {
      mediaFiles = files;
    }
  }

  void showMessage(String? message) {
    showSnackBar(context, message);
  }

  void onDelete(int index) {
    mediaBloc.add(
      DeleteFile(
        caseId: widget.caseId,
        documentId: mediaFiles[index].id,
        type: widget.documentType,
      ),
    );
  }

  void onCapture(XFile? file) {
    if (file != null) {
      final mediaFile = File(file.path);

      mediaBloc.add(
        UploadFile(
          caseId: widget.caseId,
          type: widget.documentType,
          file: mediaFile,
        ),
      );
    }
  }
}
