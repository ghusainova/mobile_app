import 'package:flutter/material.dart';

import '../../../../../../components/styles/app_colors.dart';
import 'auto_detail_buttons/auto_detail_buttons.dart';
import 'car_loan/car_loan_form.dart';
import 'characteristics/characteristics_form.dart';
import 'equipment/equipment_form.dart';
import 'main_info_section/main_info_section.dart';
import 'similar_auto_widget.dart';

class AutoDetailContent extends StatelessWidget {
  final bool fromApprovedCredit;

  const AutoDetailContent({
    super.key,
    this.fromApprovedCredit = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.lightGray,
      child: Column(
        children: [
          const Expanded(
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Column(
                children: [
                  MainInfoSection(),
                  CharactericticsForm(),
                  EquipmentForm(),
                  CarLoanForm(),
                  SimilarAutoForm(),
                ],
              ),
            ),
          ),
          AutoDetailsButtons(fromApprovedCredit: fromApprovedCredit),
        ],
      ),
    );
  }
}
