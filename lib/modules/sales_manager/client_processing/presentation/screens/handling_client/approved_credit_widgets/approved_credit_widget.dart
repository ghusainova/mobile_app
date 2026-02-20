import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../config/injectable/injectable.dart';
import '../../../../../../../components/widgets/card_widget/card_widget.dart';
import '../../../../domain/approved_credit/approved_credit_bloc.dart';
import 'credit_empty_plug_widget.dart';
import 'credit_info_widget.dart';

class ApprovedCreditWidget extends StatefulWidget {
  final String? iin;

  const ApprovedCreditWidget(this.iin, {super.key});

  @override
  State<ApprovedCreditWidget> createState() => _ApprovedCreditWidgetState();
}

class _ApprovedCreditWidgetState extends State<ApprovedCreditWidget> {
  final approvedCreditBloc = getIt.get<ApprovedCreditBloc>();

  @override
  void initState() {
    super.initState();
    approvedCreditBloc.add(GetCreditStatus(widget.iin));
  }

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      title: 'Авто с одобренной заявкой',
      contentPadding: EdgeInsets.zero,
      margin: const EdgeInsets.only(bottom: 16),
      child: BlocProvider.value(
        value: approvedCreditBloc,
        child: BlocBuilder<ApprovedCreditBloc, ApprovedCreditState>(
          builder: (context, state) => state.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            hasCredit: (approvedCredit) => CreditInfoWidget(approvedCredit),
            noCredit: () => const CreditEmptyPlugWidget(),
          ),
        ),
      ),
    );
  }
}
