import 'package:flutter/material.dart';
import '../../modules/shared/_data/enums/status_type_enum.dart';

class StatusWidget extends StatelessWidget {
  final StatusTypeEnum? status;
  final String? title;
  final String subtitle;
  final EdgeInsets margin;
  final bool infoCard;
  final double? width;

  const StatusWidget({
    required this.subtitle,
    super.key,
    this.title,
    this.status = StatusTypeEnum.warning,
    this.margin = EdgeInsets.zero,
    this.infoCard = false,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    if (status == null) {
      return const SizedBox();
    }

    return Container(
      width: width,
      margin: margin,
      decoration: BoxDecoration(
        color: status!.bgColor,
        borderRadius:
            infoCard ? BorderRadius.circular(12) : BorderRadius.circular(8),
      ),
      padding: infoCard
          ? const EdgeInsets.symmetric(vertical: 12, horizontal: 16)
          : const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            status!.icon,
            color: status!.iconColor,
            size: infoCard ? 26 : 20,
          ),
          const SizedBox(width: 12),
          Flexible(
            fit: FlexFit.loose,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if ((title ?? '').isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text(
                      title!,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(fontSize: 14, color: status!.textColor),
                    ),
                  ),
                if (subtitle.isNotEmpty)
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: status!.textColor,
                          fontSize: infoCard ? 14 : 12,
                        ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
