import 'package:flutter/material.dart';

import '../../../../../components/UI/search_bar_widget.dart';
import '../../../../../components/widgets/page_form_widget.dart';
import 'widgets/cars_to_transfer_list_widget.dart';

class CarsToTransferPage extends StatelessWidget {
  const CarsToTransferPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageFormWidget(
      appBarTitle: '',
      pageTitle: 'Все авто для передачи эвакуатору',
      showAppBarUserData: true,
      useOnlyTitlePadding: true,
      children: [
        SearchBarWidget(initialText: '', onSearch: (text) {}),
        const CarsToTransferListWidget(),
      ],
    );
  }
}
