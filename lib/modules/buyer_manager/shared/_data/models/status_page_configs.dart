import '../../../../shared/_data/enums/status_type_enum.dart';

class StatusPageConfigs {
  String appBarTitle;
  String title;
  String? subtitle;
  String buttonText;
  String routePath;
  final void Function()? onPressed;
  StatusTypeEnum statusType;

  StatusPageConfigs({
    required this.appBarTitle,
    required this.title,
    required this.routePath,
    this.subtitle,
    this.buttonText = 'Вернуться к заявке',
    this.statusType = StatusTypeEnum.info,
    this.onPressed,
  });
}
