import 'package:flutter/material.dart';

import '../../../../../components/widgets/buttons/outlined_blue_button.dart';

class TimelineButton extends StatelessWidget {
  final String? title;
  final void Function()? onRouteNav;

  const TimelineButton({
    super.key,
    required this.title,
    required this.onRouteNav,
  });

  @override
  Widget build(BuildContext context) {
    if (title == null || onRouteNav == null) {
      return const SizedBox();
    }

    return OutlinedBlueButton(
      text: title!,
      slim: true,
      margin: const EdgeInsets.only(right: 160),
      onPressed: onRouteNav!,
    );
  }
}
