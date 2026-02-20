import 'package:flutter/material.dart';

import '../../../../../components/styles/app_colors.dart';
import '../../../../../components/widgets/appbar/appbar_widget.dart';
import 'widgets/car_data_widget.dart';
import 'widgets/decision_info/decision_info_widget.dart';
import 'widgets/floating_buttons_widget.dart';

class CarInspectionReportPage extends StatelessWidget {
  const CarInspectionReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backBase,
      appBar: const AppBarWidget('Акт осмотра'),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 165),
            child: ListView(
              children: const [
                DecisionInfoWidget(hasDecision: false),
                CarDataWidget(),
              ],
            ),
          ),
          const Positioned(
            bottom: 0,
            child: FloatingButtonsWidget(),
          ),
        ],
      ),
    );
  }
}
