import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../shared/_data/constants/global_constants.dart';
import '../../../../../../../components/styles/app_colors.dart';
import '../../../../../catalog/data/models/credit.dart';
import '../../../../domain/car_loan/car_loan_bloc.dart';

class CreditTermOptions extends StatefulWidget {
  final Credit creditInfo;

  const CreditTermOptions({required this.creditInfo, super.key});

  @override
  State<CreditTermOptions> createState() => _CreditTermOptionsState();
}

class _CreditTermOptionsState extends State<CreditTermOptions> {
  int? _selectedOption;

  @override
  void initState() {
    super.initState();
    _selectedOption = widget.creditInfo.creditTerm;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: Constants.creditTerms.map(
        (option) {
          final isSelected = option == _selectedOption;

          return ChoiceChip(
            label: Container(
              width: MediaQuery.of(context).size.width / 13.5,
              height: 16,
              alignment: Alignment.center,
              child: Text(
                option.toString(),
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: isSelected ? Colors.white : null),
              ),
            ),
            backgroundColor: AppColors.backBase,
            selectedColor: AppColors.red,
            labelPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            selected: isSelected,
            onSelected: (value) => _onSelected(option),
          );
        },
      ).toList(),
    );
  }

  void _onSelected(int option) {
    final carLoanBloc = context.read<CarLoanBloc>();
    final credit = carLoanBloc.currentCredit;

    if (credit.creditTerm == option) {
      return;
    }

    if (mounted) {
      setState(() => _selectedOption = option);
    }

    carLoanBloc.add(
      ChangeCarLoan(
        _selectedOption != null
            ? credit.copyWith(creditTerm: _selectedOption!)
            : credit,
      ),
    );
  }
}
