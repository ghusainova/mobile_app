import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../components/widgets/appbar/appbar_widget.dart';
import '../../../../../components/widgets/buttons/blue_button.dart';
import '../../../../../components/widgets/snackbar/snackbar.dart';
import '../../../../../config/injectable/injectable.dart';
import '../../../../shared/media_capture_vin/presentation/screens/widgets/vin_find_info_widget.dart';
import '../../../credit_application/domain/credit_application/credit_application_bloc.dart'
    as cab;
import '../../data/enums/vin_credit_media_file_type_enum.dart';
import '../../data/models/credit_media_capture_route_args.dart';
import '../../data/models/credit_media_file.dart';
import '../../data/models/credit_photo_inspection_info_item.dart';
import '../../domain/bloc/credit_media_capture_bloc.dart';
import 'widgets/credit_media_form.dart';

class CreditPhotoCaptureVinPage extends StatefulWidget {
  final CreditMediaCaptureRouteArgs args;

  const CreditPhotoCaptureVinPage(this.args, {super.key});

  @override
  State<CreditPhotoCaptureVinPage> createState() =>
      _CreditPhotoCaptureVinPageState();
}

class _CreditPhotoCaptureVinPageState extends State<CreditPhotoCaptureVinPage> {
  final mediaBloc = getIt.get<CreditMediaCaptureBloc>();
  late final String? orderId;
  List<CreditMediaFile> mediaFiles = [];
  List<CreditPhotoInspectionInfoItem> infoItems = [];

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
    return Scaffold(
      appBar: const AppBarWidget(
        'Фото VIN-кода',
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Text(
              'Сделайте фото всех VIN-кодов, которые есть на кузове авто',
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
          const VinFindInfoWidget(),
          BlocProvider.value(
            value: mediaBloc,
            child:
                BlocConsumer<CreditMediaCaptureBloc, CreditMediaCaptureState>(
              listener: (context, state) => state.whenOrNull(
                loaded: mapInfoItems,
                uploaded: () =>
                    showSnackBar(context, 'Файл отправлен на загрузку'),
                deleted: () => showSnackBar(context, 'Файл удален'),
                error: (error) => showSnackBar(context, error),
              ),
              builder: (context, state) => CreditMediaForm(
                inspectionInfoItems: infoItems,
                onDelete: onDelete,
                onCapture: (file) => onCapture(file),
              ),
            ),
          ),
          BlueButton(onPressed: () => onSubmit(context)),
        ],
      ),
    );
  }

  void initBloc() {
    orderId = getIt.get<cab.CreditApplicationBloc>().orderId;
    mediaBloc.add(
      GetMediaFiles(
        orderId: orderId,
        fileType: VinCreditMediaFileTypeEnum.photo.fileType,
        category: VinCreditMediaFileTypeEnum.photo.category,
      ),
    );
  }

  void mapInfoItems(List<CreditMediaFile> files) {
    mediaFiles = files
        .where((element) => element.category == widget.args.category)
        .toList();

    infoItems = mediaFiles
        .map(
          (e) => CreditPhotoInspectionInfoItem(
            imagePath: e.fileLink,
            fileType: e.fileType,
            category: e.category,
            isAdditional: true,
          ),
        )
        .toList();
  }

  void onDelete(int index) {
    if (mediaFiles.isEmpty || mediaFiles.length < index) {
      return;
    }

    mediaBloc.add(
      DeleteFile(
        fileId: mediaFiles[index].id,
        orderId: orderId,
        fileType: VinCreditMediaFileTypeEnum.photo.fileType,
        category: widget.args.category,
      ),
    );
  }

  void onCapture(XFile? file) {
    if (file != null) {
      mediaBloc.add(
        UploadFile(
          orderId: orderId,
          fileType: VinCreditMediaFileTypeEnum.photo.fileType,
          category: widget.args.category,
          file: File(file.path),
        ),
      );
    }
  }

  Future<void> onSubmit(BuildContext context) async {
    if (mediaFiles.isEmpty) {
      showSnackBar(context, 'Загрузите фото');
      return;
    } else if (mediaBloc.state is Loading) {
      showSnackBar(context, 'Идет загрузка фото, подождите');
      return;
    }

    if (mounted) {
      widget.args.onFinalRoute();
    }
  }
}
