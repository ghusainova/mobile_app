import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../components/router/app_router.dart';
import '../../../../../../components/router/data/routes.dart';
import '../../../../../../components/styles/app_assets.dart';
import '../../../../../../components/widgets/appbar/appbar_widget.dart';
import '../../../../../../components/widgets/buttons/blue_button.dart';
import '../../../../../../components/widgets/buttons/outlined_blue_button.dart';
import '../../../../../../components/widgets/snackbar/snackbar.dart';
import '../../../../../../config/injectable/injectable.dart';
import '../../../../credit_application/domain/credit_application/credit_application_bloc.dart';
import '../../../data/models/credit_media_file.dart';
import '../../../data/models/credit_photo_inspection_args.dart';
import '../../../data/models/credit_photo_inspection_info_item.dart';
import '../../../domain/bloc/credit_media_capture_bloc.dart' as cmcb;
import '../widgets/credit_media_form.dart';

class CreditPhotoInspectionPage extends StatefulWidget {
  final CreditPhotoInspectionArgs args;

  const CreditPhotoInspectionPage(this.args, {super.key});

  @override
  State<CreditPhotoInspectionPage> createState() =>
      _CreditPhotoInspectionPageState();
}

class _CreditPhotoInspectionPageState extends State<CreditPhotoInspectionPage> {
  final mediaBloc = getIt.get<cmcb.CreditMediaCaptureBloc>();
  late final String? orderId;
  List<CreditPhotoInspectionInfoItem> infoItems = [];
  List<CreditMediaFile> mediaFiles = [];

  @override
  void initState() {
    super.initState();
    orderId = getIt.get<CreditApplicationBloc>().orderId;
    infoItems.addAll(widget.args.inspectionInfoItems);
    load();
  }

  @override
  void dispose() {
    mediaBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(widget.args.title),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            widget.args.subtitle,
            style: Theme.of(context).textTheme.displayMedium,
          ),
          BlocProvider.value(
            value: mediaBloc,
            child: Column(
              children: [
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 32,
                    crossAxisSpacing: 8,
                  ),
                  itemCount: infoItems.length,
                  itemBuilder: (context, index) => BlocConsumer<
                      cmcb.CreditMediaCaptureBloc,
                      cmcb.CreditMediaCaptureState>(
                    listener: (context, state) => state.whenOrNull(
                      loaded: mapItems,
                      uploaded: () =>
                          showSnackBar(context, 'Файл отправлен на загрузку'),
                      deleted: () => showSnackBar(context, 'Файл удален'),
                      error: (error) => showSnackBar(context, error),
                    ),
                    builder: (context, state) => CreditMediaForm(
                      inspectionInfoItems: infoItems,
                      singleInfoItem: infoItems[index],
                      isLoading:
                          state is cmcb.Loading && state.itemIndex == index,
                      onCapture: (file) =>
                          onCapture(file, infoItems[index].fileType, index),
                      onDelete: (_) => onDelete(
                        infoItems[index].fileType,
                        index,
                        isAdditional: infoItems[index].isAdditional,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (widget.args.showAdditionalPhotoBtn)
            OutlinedBlueButton(
              text: 'Дополнительные фото',
              showBorder: false,
              leadingIcon: const Icon(Icons.add),
              mainAxisAlignment: MainAxisAlignment.start,
              onPressed: onAddAdditionalPhoto,
            ),
          BlocProvider.value(
            value: getIt.get<CreditApplicationBloc>(),
            child: BlocConsumer<CreditApplicationBloc, CreditApplicationState>(
              listener: (context, state) => state.whenOrNull(
                completed: onCompleted,
                noContent: (message) => showSnackBar(context, message),
              ),
              builder: (context, state) => BlueButton(
                text: widget.args.btnTitle,
                isLoading: state is Loading,
                onPressed: onSubmit,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void load() {
    mediaBloc.add(
      cmcb.GetMediaFiles(
        orderId: orderId,
        category: widget.args.category,
      ),
    );
  }

  void mapItems(List<CreditMediaFile> files) {
    mediaFiles = files;
    infoItems = infoItems.map((e) {
      final file = files.firstWhereOrNull(
        (f) => f.category == e.category && f.fileType == e.fileType,
      );

      if (file != null && file.fileLink.isNotEmpty) {
        return e.copyWith(imagePath: file.fileLink);
      }

      return e;
    }).toList();
  }

  void onCapture(
    XFile? file,
    String fileType,
    int index,
  ) async {
    final currentImagePath =
        infoItems.firstWhereOrNull((e) => e.fileType == fileType)?.imagePath;

    if ((currentImagePath ?? '').isNotEmpty &&
        currentImagePath!.contains('http')) {
      onDelete(fileType, index);
    }

    if (mounted && (file?.path ?? '').isEmpty) {
      showSnackBar(context, 'File error');
      return;
    }

    mediaBloc.add(
      cmcb.UploadFile(
        orderId: orderId,
        fileType: fileType,
        category: widget.args.category,
        file: File(file!.path),
        getFiles: false,
        itemIndex: index,
      ),
    );
  }

  void onDelete(
    String fileType,
    int index, {
    bool isAdditional = false,
  }) {
    final fileId =
        mediaFiles.firstWhereOrNull((e) => e.fileType == fileType)?.id;

    if (isAdditional) {
      setState(() => infoItems.removeAt(index));
      return;
    }

    if (fileId == null) {
      showSnackBar(context, 'File id is null');
      return;
    }

    mediaBloc.add(
      cmcb.DeleteFile(
        fileId: fileId,
        orderId: orderId,
        fileType: fileType,
        category: widget.args.category,
        getFiles: false,
        itemIndex: index,
      ),
    );
  }

  void onAddAdditionalPhoto() {
    setState(() {
      infoItems.add(
        CreditPhotoInspectionInfoItem(
          imagePath: AppAssets.imagePlaceholderIcon,
          title: 'Дополнительное фото',
          fileType: 'ADDITIONAL',
          category: widget.args.category,
          isAdditional: true,
        ),
      );
    });
  }

  void onSubmit() {
    if (mounted && infoItems.any((e) => !e.imagePath.contains('http'))) {
      showSnackBar(context, 'Загрузите фото');
      return;
    }

    if (widget.args.onSubmit != null) {
      widget.args.onSubmit!();
    } else if (mounted) {
      context.pop();
    }
  }

  void onCompleted() {
    const CreditApplicationRoute().go(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final ctx = rootNavigatorKey.currentContext;

      if (ctx != null) {
        showSnackBar(ctx, 'Авто проходит проверку');
      }
    });
  }
}
