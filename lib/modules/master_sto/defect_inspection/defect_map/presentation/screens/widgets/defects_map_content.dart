import 'package:flutter/material.dart';

import '../../../../../../../components/UI/submit_btn_widget.dart';
import '../../../../../../../components/router/app_router.dart';
import '../../../../../../../components/router/data/routes.dart';
import '../../../../../../../components/widgets/card_widget/card_widget.dart';
import '../../../../../../../components/widgets/snackbar/snackbar.dart';
import '../../../../../../../config/injectable/injectable.dart';
import '../../../../../equipment_inspection/data/enum/inspection_item_enum.dart';
import '../../../../../history/domain/history/history_bloc.dart';
import '../../../../../scan_cases/domain/scan_cases/scan_cases_bloc.dart' as sc;
import '../../../../_shared/data/models/defect_model.dart';
import 'defects_map.dart';

class DefectMapContent extends StatefulWidget {
  final List<DefectModel> defectList;
  const DefectMapContent({super.key, required this.defectList});

  @override
  State<DefectMapContent> createState() => _DefectMapContentState();
}

class _DefectMapContentState extends State<DefectMapContent> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const CardWidget(
          margin: EdgeInsets.only(bottom: 16),
          title: 'Убедитесь, что вы \nосмотрели все элементы \nкузова',
        ),
        CardWidget(
          boxPadding: EdgeInsets.zero,
          child: DefectsMap(defectList: widget.defectList),
        ),
        SubmitBtnWidget(
          text: 'Подтвердить и продолжить',
          isLoading: isLoading,
          onPressed: _navigateToNextStage,
        ),
      ],
    );
  }

  void _navigateToNextStage() async {
    if (mounted) setState(() => isLoading = true);

    final isStageSaved =
        await getIt.get<HistoryBloc>().setOrderByName('Подтверждение осмотра');

    if (mounted) {
      setState(() => isLoading = false);
      isStageSaved
          ? AppRouter().router.customPushAndRemoveUntil(navigateToNextScreen)
          : showSnackBar(context, 'Этап не сохранился, попробуйте еще раз');
    }
  }

  void navigateToNextScreen() {
    final isParking = getIt.get<sc.ScanCasesBloc>().scanCase?.isParking;
    if (isParking == true) {
      const MainInspectionFormRoute(InspectionItemEnum.bodyFrame).push(context);
    } else {
      const WheelsInspectionFormRoute(InspectionItemEnum.tires).push(context);
    }
  }
}
