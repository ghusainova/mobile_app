import 'package:flutter/material.dart';

import '../../../../../components/router/data/routes.dart';
import '../../../../../components/widgets/buttons/blue_button.dart';
import '../../../../../components/widgets/page_form_widget.dart';
import '../../../../../components/widgets/text_field_widget.dart';

class OwnerAddressSubmitPage extends StatelessWidget {
  const OwnerAddressSubmitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageFormWidget(
      appBarTitle: 'Адрес владельца авто',
      children: [
        Expanded(
          child: ListView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  'Подтвердите адрес владельца авто',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 16),
                child: TextFieldWidget(
                  labelText: 'Город',
                  readOnly: true,
                  suffixIcon: Icon(Icons.keyboard_arrow_down_rounded),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 16),
                child: TextFieldWidget(
                  labelText: 'Район',
                  readOnly: true,
                  suffixIcon: Icon(Icons.keyboard_arrow_down_rounded),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 16),
                child: TextFieldWidget(labelText: 'Улица'),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 16),
                child: TextFieldWidget(labelText: 'Дом'),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 16),
                child: TextFieldWidget(labelText: 'Квартира'),
              ),
            ],
          ),
        ),
        BlueButton(
          onPressed: () => const MoneyTransferSelectionRoute().push(context),
        ),
      ],
    );
  }
}
