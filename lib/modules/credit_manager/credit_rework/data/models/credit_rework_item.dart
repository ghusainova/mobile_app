import 'dart:ui';

class CreditReworkItem {
  final String title;
  final String? comment;
  final String iconPath;
  final String code;
  final VoidCallback onRouteNav;

  const CreditReworkItem({
    required this.title,
    required this.iconPath,
    required this.code,
    required this.onRouteNav,
    this.comment,
  });
}
