import 'package:flutter/material.dart';

import 'card_border_type_enum.dart';

class CardWidget extends StatelessWidget {
  final String? title;
  final double? height;
  final CardBorderTypeEnum borderRadius;
  final EdgeInsets boxPadding;
  final EdgeInsets contentPadding;
  final EdgeInsets? margin;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final bool shadow;
  final Widget? titleChild;
  final Widget? expandedChild;
  final Widget? child;

  const CardWidget({
    super.key,
    this.title,
    this.height,
    this.borderRadius = CardBorderTypeEnum.all,
    this.boxPadding = const EdgeInsets.symmetric(vertical: 16),
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 16),
    this.margin,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.shadow = false,
    this.titleChild,
    this.expandedChild,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: height,
      padding: boxPadding,
      margin: margin,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: borderRadius.value,
        boxShadow: shadow
            ? [
                const BoxShadow(
                  offset: Offset(0, -4),
                  color: Colors.black12,
                  blurRadius: 16,
                ),
              ]
            : null,
      ),
      child: Column(
        crossAxisAlignment: crossAxisAlignment,
        mainAxisAlignment: mainAxisAlignment,
        children: [
          if (title != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16)
                  .copyWith(bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 2,
                    child: Text(
                      title!,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ),
                  if (titleChild != null) Expanded(child: titleChild!),
                ],
              ),
            ),
          if (expandedChild != null)
            expandedChild!
          else if (child != null)
            Padding(
              padding: contentPadding,
              child: child,
            ),
        ],
      ),
    );
  }
}
