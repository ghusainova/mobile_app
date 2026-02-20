import 'package:flutter/material.dart';
import 'appbar_back_widget.dart';
import 'appbar_close_action_widget.dart';
import 'appbar_profile_widget.dart';
import 'appbar_title_widget.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool automaticallyImplyLeading;
  final bool centerTitle;
  final bool showUserData;
  final bool showBackButton;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final Widget? backBtnIcon;
  final List<Widget>? customActions;
  final void Function()? onBackBtnTap;
  final void Function()? onCloseBtnTap;

  const AppBarWidget(
    this.title, {
    super.key,
    this.automaticallyImplyLeading = false,
    this.centerTitle = true,
    this.showUserData = false,
    this.showBackButton = true,
    this.foregroundColor,
    this.backgroundColor,
    this.backBtnIcon,
    this.customActions,
    this.onBackBtnTap,
    this.onCloseBtnTap,
  });

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: automaticallyImplyLeading,
      centerTitle: centerTitle,
      title: AppbarTitleWidget(title, textColor: foregroundColor),
      elevation: 0,
      backgroundColor: backgroundColor,
      leading: _getLeading(),
      actions: _getActions(),
    );
  }

  Widget? _getLeading() {
    if (showBackButton) {
      return AppbarBackWidget(
        customIcon: backBtnIcon,
        onPressed: onBackBtnTap,
      );
    }

    return null;
  }

  List<Widget>? _getActions() {
    if (customActions != null) {
      return customActions!;
    } else if (title == null) {
      return [const AppbarProfileWidget()];
    } else if (onCloseBtnTap != null) {
      return [AppBarCloseActionWidget(onPressed: onCloseBtnTap)];
    }

    return null;
  }
}
