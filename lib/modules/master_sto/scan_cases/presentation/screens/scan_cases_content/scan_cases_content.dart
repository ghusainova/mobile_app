import 'package:flutter/material.dart';
import '../../../../../../components/widgets/snackbar/snackbar.dart';
import '../../../../../../config/injectable/injectable.dart';
import '../../../data/models/scan_case.dart';

import '../../../domain/scan_cases/scan_cases_bloc.dart';

import 'cases_lists/in_progress_cases_list.dart';
import 'cases_lists/new_cases_list.dart';
import 'search_form.dart';

class ScanCasesContent extends StatefulWidget {
  const ScanCasesContent({super.key});

  @override
  State<ScanCasesContent> createState() => _ScanCasesContentState();
}

class _ScanCasesContentState extends State<ScanCasesContent> {
  List<ScanCase> filteredList = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CasesSearchForm(
          filteredList: filteredList,
          onSearch: (newFilteredList) =>
              setState(() => filteredList = newFilteredList),
          onCaseTap: anyCaseTapEvent,
        ),
        if (filteredList.isEmpty)
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: [
                NewCasesWidget(onPressed: anyCaseTapEvent),
                InProgressCasesList(onPressed: anyCaseTapEvent),
              ],
            ),
          ),
      ],
    );
  }

  void anyCaseTapEvent(ScanCase? scanCase) {
    if (scanCase == null || scanCase.caseId.isEmpty) {
      showSnackBar(context, 'Не выбрана заявка, пожалуйста отметьте нужную');
      return;
    }

    getIt.get<ScanCasesBloc>().add(
          SetCaseInWork(
            scanCase: scanCase,
            isCaseInProgress: scanCase.status != 'new',
          ),
        );
  }
}
