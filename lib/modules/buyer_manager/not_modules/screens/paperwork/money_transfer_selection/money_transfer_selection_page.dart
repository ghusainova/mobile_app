import 'package:flutter/material.dart';

import '../../../../../../components/router/data/routes.dart';
import '../../../../../../components/styles/app_colors.dart';
import '../../../../../../components/widgets/appbar/appbar_widget.dart';
import '../../../../../../components/widgets/buttons/blue_button.dart';
import 'correspondent_accounts_widget.dart';
import 'other_bank_account_details_widget.dart';

class MoneyTransferSelectionPage extends StatefulWidget {
  const MoneyTransferSelectionPage({super.key});

  @override
  State<MoneyTransferSelectionPage> createState() =>
      _MoneyTransferSelectionPageState();
}

class _MoneyTransferSelectionPageState
    extends State<MoneyTransferSelectionPage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: selectedIndex == 0 ? null : AppColors.backBase,
      appBar: const AppBarWidget('Счет для зачисления денег'),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              children: [
                CorrespondentAccountsWidget(
                  onSelect: (index) => setState(() => selectedIndex = index),
                ),
                if (selectedIndex == 1) const OtherBankAccountDetails(),
              ],
            ),
          ),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: BlueButton(
              margin: EdgeInsets.zero,
              onPressed: () => onSubmit(context),
            ),
          ),
        ],
      ),
    );
  }

  void onSubmit(BuildContext context) {
    SalesContractRoute(
      SalesContractRouteArgs(
        title: 'Договор купли-продажи',
        subtitle:
            'Подпишите договор купли продажи с владельцем авто и отсканируйте подписанный договор',
        onSubmit: () => navigateToCertAccept(context),
      ),
    ).push(context);
  }

  void navigateToCertAccept(BuildContext context) {
    SalesContractRoute(
      SalesContractRouteArgs(
        title: 'Акт приема передачи',
        subtitle:
            'Подпишите акт приема передачи с владельцем авто и отсканируйте подписанный акт',
        onSubmit: () => const BuyerQueueRoute().go(context),
      ),
    ).push(context);
  }
}
