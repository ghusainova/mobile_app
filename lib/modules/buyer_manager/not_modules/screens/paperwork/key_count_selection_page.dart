import 'package:flutter/material.dart';

import '../../../../../components/router/data/routes.dart';
import '../../../../../components/widgets/buttons/blue_button.dart';
import '../../../../../components/widgets/page_form_widget.dart';
import '../../../../../components/widgets/text_field_widget.dart';

class KeyCountSelectionPage extends StatelessWidget {
  const KeyCountSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageFormWidget(
      appBarTitle: 'Количество ключей',
      pageTitle: 'Укажите количество ключей авто',
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 16),
          child: TextFieldWidget(labelText: 'Количество ключей'),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: BlueButton(
              onPressed: () => const OwnerAddressSubmitRoute().push(context),
            ),
          ),
        ),
      ],
    );
  }
}
