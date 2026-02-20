import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../config/injectable/injectable.dart';
import '../../../../../components/widgets/buttons/segmented_control_widget.dart';
import '../../../queue/data/models/client_case_request_params.dart';
import '../../../queue/domain/buyout/buyout_bloc.dart';
import '../../../../../components/widgets/buttons/blue_button.dart';
import '../../../../../components/widgets/page_form_widget.dart';
import '../../../../../components/widgets/text_field_widget.dart';

class SearchCasePage extends StatefulWidget {
  const SearchCasePage({super.key});

  @override
  State<SearchCasePage> createState() => _SearchCasePageState();
}

class _SearchCasePageState extends State<SearchCasePage> {
  final List<String> segments = [
    'Номер телефона в Kolesa.kz',
    'Ссылка на объявление',
  ];

  String selectedSegment = '';
  String searchValue = '';

  @override
  void initState() {
    super.initState();
    selectedSegment = segments.first;
  }

  @override
  Widget build(BuildContext context) {
    return PageFormWidget(
      appBarTitle: 'Поиск заявки',
      useParentTitle: true,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: SegmentedControlWidget(
            segments: segments,
            onChange: onChange,
          ),
        ),
        TextFieldWidget(
          labelText: selectedSegment,
          onTextChanged: (text) => searchValue = text,
        ),
        Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: BlueButton(text: 'Найти заявку', onPressed: onSearch),
          ),
        ),
      ],
    );
  }

  void onChange(String value) {
    setState(() {
      selectedSegment = value;
      searchValue = '';
    });
  }

  void onSearch() {
    ClientCaseRequestParams? requestBody;

    if (selectedSegment == segments.first) {
      requestBody = ClientCaseRequestParams(sellerPhone: searchValue.trim());
    } else {
      requestBody = ClientCaseRequestParams(link: searchValue.trim());
    }

    getIt.get<BuyoutBloc>().add(GetBuyerCatalog(requestBody: requestBody));
    context.pop();
  }
}
