import 'package:flutter/material.dart';

import '../../../../../../../config/injectable/injectable.dart';
import '../../../../../../buyer_manager/queue/domain/buyout/buyout_bloc.dart';
import '../../../../../../sales_manager/auto_detail/data/models/defects.dart';
import '../../../../other_parts/presentation/screens/widgets/photo_row.dart';
import 'defects_meanings_item.dart';

class BuyerDefectPointModal extends StatelessWidget {
  final TempDefectModel defectModel;

  const BuyerDefectPointModal({
    required this.defectModel, super.key,
  });

  List<String> get defectList => defectModel.defects.split(', ');

  @override
  Widget build(BuildContext context) {
    final autoInfo = getIt.get<BuyoutBloc>().autoInfo;

    return Container(
      padding: const EdgeInsets.all(16),
      constraints: BoxConstraints(
        minWidth: MediaQuery.of(context).size.width / 1.5,
        minHeight: MediaQuery.of(context).size.height / 5,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Text(
              defectModel.title,
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: defectList.length,
            itemBuilder: (context, index) {
              final defect = defectList[index];
              return DefectMeaningsItem(defect: defect);
            },
          ),
          PhotoRow(
            type: defectModel.title,
            orderId: autoInfo?.id,
          ),
        ],
      ),
    );
  }
}
