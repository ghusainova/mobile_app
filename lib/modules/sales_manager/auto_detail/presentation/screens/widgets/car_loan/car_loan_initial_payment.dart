import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../shared/_domain/utility/formatters/price_input_formatter.dart';
import '../../../../../../../components/widgets/text_field_widget.dart';
import '../../../../../catalog/data/models/credit.dart';
import '../../../../domain/car_loan/car_loan_bloc.dart';

class CarLoanInitalPayment extends StatefulWidget {
  final Credit creditInfo;

  const CarLoanInitalPayment({required this.creditInfo, super.key});

  @override
  State<CarLoanInitalPayment> createState() => _CarLoanInitalPaymentState();
}

class _CarLoanInitalPaymentState extends State<CarLoanInitalPayment> {
  final _controller = TextEditingController();

  Timer? _debounce;
  String? errorText;

  @override
  void initState() {
    super.initState();

    _controller.text =
        formatPriceText(widget.creditInfo.initialPaymentAmount.toString());
  }

  @override
  void dispose() {
    _controller.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFieldWidget(
      margin: const EdgeInsets.only(bottom: 20),
      labelText: 'Первоначальный взнос',
      errorText: errorText,
      textController: _controller,
      keyboardType: TextInputType.number,
      usePriceFormatter: true,
      onTextChanged: onValidate,
      onEditingComplete: onEdit,
    );
  }

  void onValidate(String value) {
    final formatterValue = int.tryParse(removePriceSeparators(value)) ?? 0;

    if (formatterValue < widget.creditInfo.minInitialPaymentAmount) {
      if (errorText == null) {
        setState(
          () => errorText =
              'Первоначальный взнос должен быть не меньше ${formatPriceText(widget.creditInfo.minInitialPaymentAmount.toString())}',
        );
      }
    } else if (formatterValue >= widget.creditInfo.price) {
      if (errorText == null) {
        setState(
          () => errorText =
              'Первоначальный взнос должен быть больше стоимости авто',
        );
      }
    } else {
      if (errorText != null) setState(() => errorText = null);
    }

    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () => onEdit(value));
  }

  void onEdit(String value) {
    if (errorText != null) {
      return;
    }

    final formatterValue = removePriceSeparators(value);
    final bloc = context.read<CarLoanBloc>();

    var credit = bloc.currentCredit;
    credit = credit.copyWith(initialPaymentAmount: int.parse(formatterValue));
    bloc.add(ChangeCarLoan(credit));
  }
}
