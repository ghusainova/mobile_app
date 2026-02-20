import 'package:flutter/material.dart';

import '../../../../../../../config/injectable/injectable.dart';
import '../../../../../../../components/widgets/status_widget.dart';
import '../../../../domain/buyout/buyout_bloc.dart';

class ApplicationStatus extends StatelessWidget {
  const ApplicationStatus({super.key});

  @override
  Widget build(BuildContext context) {
    final status = getIt.get<BuyoutBloc>().status;
    if (status == null) {
      return const SizedBox();
    }

    return StatusWidget(
      subtitle: status.description,
      status: status.statusTypeEnum,
      margin: const EdgeInsets.only(top: 4),
    );
  }
}
