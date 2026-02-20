import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../config/injectable/injectable.dart';
import '../../../../../../shared/media_capture_vin/data/models/media_file.dart';
import '../../../../../../shared/media_capture_vin/presentation/screens/widgets/media_form.dart';
import '../../../../../scan_cases/domain/scan_cases/scan_cases_bloc.dart';
import '../../../../data/enum/inspection_item_enum.dart';
import '../../../../data/models/inspection_item/inspection_item.dart';
import '../../../../domain/equipment_inspection/equipment_inspection_bloc.dart';

class ShowPhotoSelectionWidget extends StatelessWidget {
  final InspectionItem item;
  final String? documentType;

  const ShowPhotoSelectionWidget({
    required this.item, required this.documentType, super.key,
  });

  bool get _singlePhotoType =>
      documentType == InspectionItemEnum.computerDiagnostics.stageName ||
      documentType == InspectionItemEnum.engine.stageName;

  bool get isComputerDiagnostics =>
      documentType == InspectionItemEnum.computerDiagnostics.stageName;

  bool get _visible =>
      item.attachPhoto &&
      (item.values.any((element) =>
              !element.uncheckOthers &&
              element.selected &&
              !element.isPaintwork,) ||
          isComputerDiagnostics);

  @override
  Widget build(BuildContext context) {
    if (!_visible || documentType == null) {
      return const SizedBox();
    }

    return MediaForm(
      caseId: getIt.get<ScanCasesBloc>().scanCase?.caseId,
      documentType: documentType!,
      subType: _singlePhotoType ? null : item.name,
      cacheSize: const Size(70, 70),
      onLoaded: (mediaFiles) => _onLoaded(context, mediaFiles),
    );
  }

  void _onLoaded(BuildContext context, List<MediaFile> mediaFiles) {
    context.read<EquipmentInspectionBloc>().savePhotosCount(mediaFiles);
  }
}
