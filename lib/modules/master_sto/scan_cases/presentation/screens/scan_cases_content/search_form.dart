import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../components/widgets/snackbar/snackbar.dart';
import '../../../../../../components/UI/search_bar_widget.dart';
import '../../../data/models/scan_case.dart';

import '../../../domain/scan_cases/scan_cases_bloc.dart';
import 'cases_lists/filtered_cases_list.dart';

class CasesSearchForm extends StatelessWidget {
  final List<ScanCase> filteredList;
  final void Function(List<ScanCase> filteredList) onSearch;
  final void Function(ScanCase) onCaseTap;

  const CasesSearchForm({
    required this.filteredList,
    required this.onSearch,
    required this.onCaseTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          color: Colors.white,
          child: SearchBarWidget(
            labelText: 'Поиск по госномеру или ФИО',
            searchOnEachTap: true,
            onSearch: (value) => _onSearch(value, context),
          ),
        ),
        if (filteredList.isNotEmpty)
          FilteredCasesList(
            cases: filteredList,
            onPressed: onCaseTap,
          ),
      ],
    );
  }

  void _onSearch(String searchField, BuildContext context) {
    final cases = context.read<ScanCasesBloc>().cases ?? [];
    List<ScanCase> filteredList = [];

    if (searchField.isEmpty) {
      filteredList = [];
    } else {
      filteredList = cases.where((scanCase) {
        final regex = RegExp(searchField, caseSensitive: false);
        final hasMatch = regex.hasMatch(scanCase.stateNumber) ||
            regex.hasMatch(scanCase.clientName);

        return hasMatch;
      }).toList();
    }

    if (searchField.isNotEmpty && filteredList.isEmpty) {
      showSnackBar(context, 'Ничего не найдено');
    }

    onSearch(filteredList);
  }
}
