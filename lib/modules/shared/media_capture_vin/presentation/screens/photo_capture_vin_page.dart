import 'package:flutter/material.dart';
import '../../../../../config/injectable/injectable.dart';
import '../../../../../components/router/data/routes.dart';
import '../../../../../components/widgets/appbar/appbar_widget.dart';
import '../../../../../components/widgets/buttons/blue_button.dart';
import '../../../../../components/widgets/snackbar/snackbar.dart';
import '../../../../master_sto/history/domain/history/history_bloc.dart' as hb;
import '../../data/models/media_capture_route_args.dart';
import '../../data/models/media_file.dart';
import '../../domain/media_capture_vin/media_capture_vin_bloc.dart';
import 'widgets/media_form.dart';
import '../../data/enum/media_capture_file_type_enum.dart';
import 'widgets/vin_find_info_widget.dart';

class PhotoCaptureVinPage extends StatefulWidget {
  final MediaCaptureRouteArgs args;

  const PhotoCaptureVinPage(this.args, {super.key});

  @override
  State<PhotoCaptureVinPage> createState() => _PhotoCaptureVinPageState();
}

class _PhotoCaptureVinPageState extends State<PhotoCaptureVinPage> {
  final title = 'Фото VIN-кода';
  bool isEmptyImageList = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title,
        onCloseBtnTap: () => const MasterStoRoute().go(context),
      ),
      body: RefreshIndicator(
        onRefresh: onRefresh,
        child: ListView(
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
            MediaForm(
              caseId: widget.args.caseId,
              documentType: MediaTypeEnum.photo.code,
              onLoading: () => setState(() => isLoading = true),
              onLoaded: onLoaded,
            ),
            BlueButton(onPressed: () => onSubmit(context)),
          ],
        ),
      ),
    );
  }

  Future<void> onSubmit(BuildContext context) async {
    if (isEmptyImageList) {
      showMessage('Загрузите фото');
      return;
    } else if (isLoading) {
      showMessage('Идет загрузка фото, подождите');
      return;
    }

    final isStageSaved = widget.args.saveHistoryStage
        ? await getIt.get<hb.HistoryBloc>().setOrderByName(title)
        : true;

    if (isStageSaved && mounted) {
      widget.args.onFinalRoute();
    } else {
      showMessage('Этап не сохранился, попробуйте еще раз');
    }
  }

  void onLoaded(List<MediaFile> mediaFiles) {
    setState(() {
      isEmptyImageList = mediaFiles.isEmpty;
      isLoading = false;
    });
  }

  void showMessage(String? message) {
    showSnackBar(context, message);
  }

  Future<void> onRefresh() async {
    getIt.get<MediaCaptureVinBloc>().add(
          GetMediaFiles(
            caseId: widget.args.caseId,
            type: MediaTypeEnum.photo.code,
          ),
        );
  }
}
