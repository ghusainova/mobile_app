import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../components/router/data/routes.dart';
import '../../../../../../components/styles/app_assets.dart';
import '../../../../../../components/widgets/buttons/blue_button.dart';
import '../../../../../../components/widgets/buttons/outlined_blue_button.dart';
import '../../../domain/bloc/queue_bloc.dart';

class CallNewClientWidget extends StatelessWidget {
  final int queueLength;

  const CallNewClientWidget({
    required this.queueLength,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: RefreshIndicator(
        onRefresh: () => _onRefresh(context),
        child: ListView(
          children: [
            Padding(
              padding:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 4),
              child: SvgPicture.asset(AppAssets.visitorsIcon),
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 24, bottom: 8),
              child: Text(
                'Вызов по очереди',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                'В очереди: $queueLength',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            BlueButton(
              text: queueLength > 0 ? 'Вызвать' : 'Обновить очередь',
              margin: const EdgeInsets.all(16),
              onPressed: () => _callClientFromQueue(context),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: OutlinedBlueButton(
                text: 'Вызвать по номеру талона или ИИН',
                onPressed: () => const CallClientByIinRoute().push(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _callClientFromQueue(BuildContext context) {
    context.read<QueueBloc>().add(const CallClient());
  }

  Future<void> _onRefresh(BuildContext context) async {
    context.read<QueueBloc>().add(const GetManagerState());
  }
}
