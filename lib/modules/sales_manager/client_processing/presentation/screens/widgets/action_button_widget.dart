import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../shared/_domain/bloc/timers/coundown_timer/countdown_timer_bloc.dart';
import '../../../../../shared/_domain/utility/ticker.dart';
import '../../../../../../components/styles/app_assets.dart';
import '../../../../../../components/styles/app_colors.dart';
import '../../../../../../components/widgets/buttons/outlined_blue_button.dart';

class ActionButtonWidget extends StatelessWidget {
  final VoidCallback onTap;

  const ActionButtonWidget(this.onTap, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _initBloc(),
      child: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: BlocBuilder<CountdownTimerBloc, CountdownTimerState>(
          builder: (context, state) => state.when(
            inProgress: (duration) => Text(
              'Вызвать повторно через $duration сек.',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: AppColors.inactiveText),
            ),
            completed: () => OutlinedBlueButton(
              mainAxisAlignment: MainAxisAlignment.center,
              text: 'Вызвать повторно',
              leadingIcon: SvgPicture.asset(AppAssets.refreshIcon),
              slim: true,
              onPressed: () => _onTap(context),
            ),
          ),
        ),
      ),
    );
  }

  CountdownTimerBloc _initBloc() {
    return CountdownTimerBloc(ticker: const Ticker())..add(const Start(20));
  }

  void _onTap(BuildContext context) {
    context.read<CountdownTimerBloc>().add(const Start(20));
    onTap();
  }
}
