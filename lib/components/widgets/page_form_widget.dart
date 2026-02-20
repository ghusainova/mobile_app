import 'package:flutter/material.dart';

import 'appbar/appbar_widget.dart';

class PageFormWidget extends StatelessWidget {
  final String appBarTitle;
  final String? pageTitle;
  final bool showAppBarUserData;
  final bool useParentTitle;
  final bool useOnlyTitlePadding;
  final MainAxisSize mainAxisSize;
  final MainAxisAlignment mainAxisAlignment;
  final List<Widget>? children;
  final Widget? child;

  const PageFormWidget({
    required this.appBarTitle, super.key,
    this.pageTitle,
    this.showAppBarUserData = false,
    this.useParentTitle = false,
    this.useOnlyTitlePadding = false,
    this.mainAxisSize = MainAxisSize.max,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.children,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        showAppBarUserData ? null : appBarTitle,
        showBackButton: !showAppBarUserData,
        showUserData: showAppBarUserData,
      ),
      body: Padding(
        padding:
            useOnlyTitlePadding ? EdgeInsets.zero : const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: mainAxisSize,
          mainAxisAlignment: mainAxisAlignment,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (pageTitle != null || useParentTitle)
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: useOnlyTitlePadding ? 16 : 0,
                ).copyWith(bottom: 8),
                child: Text(
                  useParentTitle ? appBarTitle : (pageTitle ?? ''),
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
            if (children != null)
              ...children!
            else if (child != null)
              Expanded(child: child!),
          ],
        ),
      ),
    );
  }
}
