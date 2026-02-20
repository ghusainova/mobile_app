import 'package:flutter/material.dart';

import '../../../../../../components/UI/search_bar_widget.dart';
import '../../../../../../config/injectable/injectable.dart';
import '../../../../credit_application/data/models/credit_application.dart';
import '../../../domain/applications_in_progress/applications_in_progress_bloc.dart';
import 'credit_application_item_widget.dart';

class ApplicationsInProgressContent extends StatelessWidget {
  final List<CreditApplication> creditApplicationList;
  const ApplicationsInProgressContent({
    super.key,
    required this.creditApplicationList,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16).copyWith(bottom: 8),
          child: Text(
            'Заявки в работе',
            style: Theme.of(context).textTheme.displayMedium,
          ),
        ),
        SearchBarWidget(
          onSearch: _onSearch,
          labelText: 'ФИО, ИИН, номер телефона',
        ),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: creditApplicationList.length,
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            itemBuilder: (context, index) =>
                CreditApplicationItemWidget(item: creditApplicationList[index]),
          ),
        ),
      ],
    );
  }

  void _onSearch(String searchValue) {
    getIt.get<ApplicationsInProgressBloc>().add(Search(searchValue));
  }
}
