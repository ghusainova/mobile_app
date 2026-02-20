import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../config/injectable/injectable.dart';
import '../../../../../../../components/widgets/buttons/blue_button.dart';
import '../../../../../../../components/widgets/buttons/outlined_blue_button.dart';
import '../../../../../../../components/widgets/card_widget/card_widget.dart';
import '../../../../../../../components/widgets/snackbar/snackbar.dart';
import '../../../../../scan_cases/domain/scan_cases/scan_cases_bloc.dart' as sc;
import '../../../../_shared/data/enum/car_body_part.dart';
import '../../../../_shared/data/models/defect.dart';
import '../../../domain/defects/defects_bloc.dart';
import 'modals/defect_modal.dart';

class DefectButtons extends StatefulWidget {
  final CarBodyPart bodyPart;
  const DefectButtons({
    required this.bodyPart,
    super.key,
  });

  @override
  State<DefectButtons> createState() => _DefectButtonsState();
}

class _DefectButtonsState extends State<DefectButtons> {
  @override
  Widget build(BuildContext context) {
    return CardWidget(
      margin: const EdgeInsets.only(top: 16),
      child: Column(
        children: [
          OutlinedBlueButton(
            text: 'Указать дефект',
            onPressed: _onSelectDefect,
          ),
          BlueButton(
            isLoading: context.read<DefectsBloc>().state is Loading,
            text: 'Продолжить',
            margin: const EdgeInsets.only(top: 16),
            onPressed: _onSave,
          ),
        ],
      ),
    );
  }

  void _onSelectDefect() {
    final defectList = context.read<DefectsBloc>().defect.defects ?? [];

    showModalBottomSheet(
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
      context: context,
      isScrollControlled: true,
      builder: (context) => DefectModal(
        defects: defectList,
        onReset: _onReset,
        onSelect: _onSelect,
      ),
    );
  }

  void _onReset() {
    context.read<DefectsBloc>().add(const DefectsEvent.resetDefectStatus());
  }

  void _onSelect(List<Defect> updatedDefects) {
    context.read<DefectsBloc>().add(
          DefectsEvent.updateDefectStatus(updatedDefects),
        );
  }

  void _onSave() {
    final bloc = context.read<DefectsBloc>();
    final isParking = getIt.get<sc.ScanCasesBloc>().scanCase?.isParking;

    if (isParking == false &&
        bloc.mediaFiles.isEmpty &&
        bloc.defect.isDefectListEmpty == false) {
      showSnackBar(context, 'Загрузите фото дефектов');
      return;
    }

    bloc.add(const DefectsEvent.save(setStage: true));
  }
}
