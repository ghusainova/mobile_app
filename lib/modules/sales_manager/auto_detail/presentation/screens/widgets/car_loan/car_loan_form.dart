import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../config/injectable/injectable.dart';
import '../../../../../../../components/widgets/card_widget/card_widget.dart';
import '../../../../domain/auto_detail/auto_detail_bloc.dart';
import '../../../../domain/car_loan/car_loan_bloc.dart';
import 'annual_payment_form.dart';
import 'car_loan_initial_payment.dart';
import 'car_loan_price.dart';

class CarLoanForm extends StatefulWidget {
  const CarLoanForm({super.key});

  @override
  State<CarLoanForm> createState() => _CarLoanFormState();
}

class _CarLoanFormState extends State<CarLoanForm> {
  final carLoanBloc = getIt.get<CarLoanBloc>();

  @override
  void initState() {
    super.initState();
    initBloc();
  }

  @override
  void dispose() {
    carLoanBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      title: 'Рассчитать автокредит',
      margin: const EdgeInsets.only(bottom: 12),
      child: BlocProvider.value(
        value: carLoanBloc,
        child: BlocBuilder<CarLoanBloc, CarLoanState>(
          builder: (context, state) {
            return state.whenOrNull(
                  loading: () => const SizedBox(
                    height: 363,
                    child: Center(child: CircularProgressIndicator()),
                  ),
                  hasContent: (credit) => Column(
                    children: [
                      CarLoanPrice(creditInfo: credit),
                      CarLoanInitalPayment(creditInfo: credit),
                      AnnualPaymentForm(creditInfo: credit),
                    ],
                  ),
                ) ??
                const SizedBox();
          },
        ),
      ),
    );
  }

  void initBloc() {
    final autoInfo = context.read<AutoDetailBloc>().autoInfo;
    carLoanBloc.add(CarLoanEvent.started(autoInfo: autoInfo));
  }
}
