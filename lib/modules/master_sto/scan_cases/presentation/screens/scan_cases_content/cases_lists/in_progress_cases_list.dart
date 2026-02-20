import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../components/styles/app_colors.dart';
import '../../../../../../../components/widgets/car_inspection_list_item.dart';
import '../../../../../../../components/widgets/card_widget/card_widget.dart';
import '../../../../data/models/scan_case.dart';
import '../../../../domain/scan_cases/scan_cases_bloc.dart';

class InProgressCasesList extends StatefulWidget {
  final void Function(ScanCase) onPressed;

  const InProgressCasesList({
    required this.onPressed,
    super.key,
  });

  @override
  State<InProgressCasesList> createState() => _InProgressCasesListState();
}

class _InProgressCasesListState extends State<InProgressCasesList> {
  late final List<ScanCase> cases;

  @override
  void initState() {
    super.initState();
    cases = getCases(context);
  }

  @override
  Widget build(BuildContext context) {
    if (cases.isEmpty) {
      return const SizedBox();
    }

    return CardWidget(
      title: 'Продолжите осмотр',
      margin: const EdgeInsets.only(top: 16),
      boxPadding: const EdgeInsets.only(top: 16),
      expandedChild: ListView.separated(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        physics: const BouncingScrollPhysics(),
        separatorBuilder: (context, index) =>
            const Divider(color: AppColors.backBase),
        itemCount: cases.length,
        itemBuilder: (context, index) {
          final e = cases[index];
          return CarInspectionItem(
            title: '${e.brand} ${e.model}',
            subtitle: '${e.stateNumber} • ${e.clientName}',
            onPressed: () => widget.onPressed(e),
          );
        },
      ),
    );
  }

  List<ScanCase> getCases(BuildContext context) {
    final casesList = context.read<ScanCasesBloc>().cases;
    final filteredCases = casesList
            ?.where((scanCase) => scanCase.status == 'in progress')
            .toList() ??
        [];

    return filteredCases;
  }
}
