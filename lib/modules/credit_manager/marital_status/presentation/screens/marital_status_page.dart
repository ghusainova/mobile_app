import 'package:flutter/material.dart';

import '../../../../../config/injectable/injectable.dart';
import '../../../../../components/router/data/routes.dart';
import '../../../../../components/widgets/buttons/blue_button.dart';
import '../../../../../components/widgets/page_form_widget.dart';
import '../../../../../components/widgets/snackbar/snackbar.dart';
import '../../../credit_application/domain/credit_application/credit_application_bloc.dart';
import '../../data/constants/marital_text_const.dart';

class MaritalStatusPage extends StatefulWidget {
  const MaritalStatusPage({super.key});

  @override
  State<MaritalStatusPage> createState() => _MaritalStatusPageState();
}

class _MaritalStatusPageState extends State<MaritalStatusPage> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return PageFormWidget(
      appBarTitle: MaritalTextConst.appBarTitle,
      pageTitle: MaritalTextConst.mainTitle,
      children: [
        Text(
          MaritalTextConst.subtitle,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: BlueButton(
              text: 'Отправить сообщение',
              isLoading: isLoading,
              onPressed: () => onPressed(context),
            ),
          ),
        ),
      ],
    );
  }

  void onPressed(BuildContext context) async {
    setState(() => isLoading = true);

    final smsIsSent =
        await getIt.get<CreditApplicationBloc>().changeMaritalStatus();

    if (!context.mounted) {
      return;
    }

    setState(() => isLoading = false);

    if (smsIsSent) {
      const CreditApplicationRoute().go(context);
      showSnackBar(context, 'Сообщение отправлено');
    } else {
      showSnackBar(context, 'Ошибка, не удалось отправить сообщение');
    }
  }
}
