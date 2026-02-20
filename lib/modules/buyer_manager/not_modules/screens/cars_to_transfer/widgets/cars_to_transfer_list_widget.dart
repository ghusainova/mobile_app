import 'package:flutter/material.dart';

import 'car_to_transfer_card_widget.dart';

class CarsToTransferListWidget extends StatelessWidget {
  const CarsToTransferListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: 10,
        itemBuilder: (context, index) => const CarToTransferCardWidget(),
      ),
    );
  }
}
