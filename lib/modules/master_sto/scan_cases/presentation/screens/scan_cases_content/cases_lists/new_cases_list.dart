import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../components/styles/app_colors.dart';
import '../../../../../../../components/widgets/buttons/blue_button.dart';
import '../../../../../../../components/widgets/card_widget/card_border_type_enum.dart';
import '../../../../../../../components/widgets/card_widget/card_widget.dart';
import '../../../../../../../components/UI/radio_button_tile/radio_button_tile_widget.dart';
import '../../../../../../../components/widgets/snackbar/snackbar.dart';
import '../../../../data/models/scan_case.dart';
import '../../../../domain/scan_cases/scan_cases_bloc.dart';
import '../rework_status.dart';

class NewCasesWidget extends StatefulWidget {
  final void Function(ScanCase? scanCase) onPressed;

  const NewCasesWidget({
    required this.onPressed,
    super.key,
  });

  @override
  State<NewCasesWidget> createState() => _NewCasesWidgetState();
}

class _NewCasesWidgetState extends State<NewCasesWidget> {
  late final List<ScanCase> cases;
  int selectedIndex = 0;
  ScanCase? selectedValue;

  @override
  void initState() {
    super.initState();
    cases = getCases();
  }

  @override
  Widget build(BuildContext context) {
    if (cases.isEmpty) {
      return const SizedBox();
    }

    return CardWidget(
      title: 'Авто на осмотр',
      borderRadius: CardBorderTypeEnum.onlyBottom,
      expandedChild: Column(
        children: [
          ListView.separated(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            physics: const BouncingScrollPhysics(),
            separatorBuilder: (context, index) =>
                const Divider(color: AppColors.backBase),
            itemCount: cases.length,
            itemBuilder: (context, index) {
              final entry = cases.asMap().entries.toList()[index];
              return RadioButtonTileWidget(
                title: '${entry.value.brand} ${entry.value.model}',
                subtitle:
                    '${entry.value.stateNumber} • ${entry.value.clientName}',
                caption: entry.value.status == 'rework'
                    ? const ReworkStatus()
                    : null,
                enabled: selectedValue == cases[index],
                onTap: () => setState(() => selectedValue = cases[index]),
              );
            },
          ),
          BlueButton(
            text: 'Начать осмотр',
            margin: const EdgeInsets.all(16),
            onPressed: onSubmit,
          ),
        ],
      ),
    );
  }

  List<ScanCase> getCases() {
    final casesList = context.read<ScanCasesBloc>().cases;
    final filteredCases = casesList
            ?.where(
              (scanCase) =>
                  scanCase.status == 'new' || scanCase.status == 'rework',
            )
            .toList() ??
        [];

    return filteredCases;
  }

  void onSubmit() {
    if (selectedValue == null || selectedValue?.caseId == '') {
      showSnackBar(context, 'Не выбрана заявка, пожалуйста отметьте нужную');
      return;
    }
    widget.onPressed(selectedValue);
  }
}
