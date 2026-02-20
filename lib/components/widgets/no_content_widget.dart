import 'package:flutter/material.dart';

import '../styles/app_assets.dart';
import 'buttons/blue_button.dart';
import 'card_widget/card_border_type_enum.dart';
import 'card_widget/card_widget.dart';

class NoContentWidget extends StatelessWidget {
  final void Function() onRefresh;
  final bool fixedHeight;
  final String? errorMessage;

  const NoContentWidget({
    required this.onRefresh,
    super.key,
    this.fixedHeight = false,
    this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      height: fixedHeight ? MediaQuery.of(context).size.height / 3 : null,
      borderRadius: CardBorderTypeEnum.onlyBottom,
      expandedChild: Expanded(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                AppAssets.emptySearchImage,
                width: 140,
                height: 94,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24, bottom: 8),
                child: Text(
                  errorMessage ?? 'Ничего не найдено',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ),
              BlueButton(onPressed: onRefresh, text: 'Обновить'),
            ],
          ),
        ),
      ),
    );
  }
}
