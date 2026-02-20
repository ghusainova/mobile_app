import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/injectable/injectable.dart';
import '../../../../../../components/router/data/routes.dart';
import '../../../../../../components/styles/app_assets.dart';
import '../../../../../../components/widgets/appbar/appbar_widget.dart';
import '../../../../../shared/_data/models/auto_info.dart';
import '../../../../shared/_data/constants/application_success_configs.dart';
import '../../../domain/qr/qr_bloc.dart';
import 'widgets/qr_actions_widget.dart';
import '../../../../../../components/widgets/qr_view_widget.dart';

class QrPage extends StatelessWidget {
  final AutoInfo autoInfo;

  const QrPage(this.autoInfo, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget('Получить одобрение на автокредит'),
      body: BlocProvider.value(
        value: getIt.get<QrBloc>(),
        child: BlocConsumer<QrBloc, QrState>(
          listener: (_, state) => state.whenOrNull(
            success: () => StatusPageRoute(salesManagerConfigs).go(context),
          ),
          builder: (context, state) {
            if (state is Loading) {
              return const Center(child: CircularProgressIndicator.adaptive());
            }

            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  QrViewVidget(
                    advertLink: autoInfo.linkSell,
                    title:
                        'Попросите клиента сканировать QR и помогите получить одобрение',
                    subtitle:
                        'После того, как клиент получит решение, отправьте клиента на оформление',
                    logoPath: AppAssets.kolesaLogo,
                  ),
                  QrActionsWidget(autoInfo),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
