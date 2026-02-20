import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:go_router/go_router.dart';

import '../../../../../components/router/data/routes.dart';
import '../../../../../components/styles/app_assets.dart';

class BuyerManagerTabsPage extends StatelessWidget {
  final StatefulNavigationShell navigatorShell;

  const BuyerManagerTabsPage({required this.navigatorShell, super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                AppAssets.clientIcon,
                colorFilter: _getColorFilter(context, 0),
              ),
              label: 'Электронная очередь',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                AppAssets.infoIcon,
                colorFilter: _getColorFilter(context, 1),
              ),
              label: 'Авто для передачи',
            ),
          ],
          currentIndex: _getCurrentIndex(context),
          onTap: (value) {
            switch (value) {
              case 0:
                const BuyerQueueRoute().go(context);
                break;
              case 1:
                const CarsToTransferRoute().go(context);
                break;
            }
          },
          selectedItemColor: Colors.red,
          unselectedItemColor: Colors.grey,
        ),
        body: navigatorShell,
      ),
    );
  }

  int _getCurrentIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();

    if (location == const CarsToTransferRoute().location) {
      return 1;
    }

    return 0;
  }

  ColorFilter _getColorFilter(BuildContext context, int index) {
    return ColorFilter.mode(
      _getCurrentIndex(context) == index ? Colors.red : Colors.grey,
      BlendMode.srcIn,
    );
  }
}
