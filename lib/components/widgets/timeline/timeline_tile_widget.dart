import 'package:flutter/material.dart';

import '../../../modules/shared/_data/models/timeline_tile_item.dart';
import '../../styles/app_colors.dart';
import '../status_widget.dart';
import 'numeric_key_widget.dart';

class TimelineTileWidget extends StatefulWidget {
  final TimelineTileItem item;
  final TimelineTileItem? subItem;

  const TimelineTileWidget({
    super.key,
    required this.item,
    this.subItem,
  });

  @override
  State<TimelineTileWidget> createState() => _TimelineTileWidgetState();
}

class _TimelineTileWidgetState extends State<TimelineTileWidget> {
  final textKey = GlobalKey();
  double? timelineHeight;

  @override
  void initState() {
    super.initState();

    calculateTextHeight();
  }

  Color get timelineColor =>
      widget.item.isSelected && widget.item.lineInProgressColor != null
          ? widget.item.lineInProgressColor!
          : AppColors.fillDark;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            if (widget.item.customKeyWidget != null)
              widget.item.customKeyWidget!
            else
              NumericKeyWidget(widget.item.key.toString()),
            Container(
              width: 2,
              height: timelineHeight,
              decoration: BoxDecoration(
                color: timelineColor,
                borderRadius: BorderRadius.circular(2),
              ),
              margin:
                  const EdgeInsets.symmetric(vertical: 4).copyWith(right: 10),
            ),
          ],
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              key: textKey,
              children: [
                RichText(
                  text: TextSpan(
                    children: _highlightWords(),
                  ),
                ),
                if (widget.item.subtitle.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      widget.item.subtitle,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: AppColors.inactiveText),
                    ),
                  ),
                if (widget.subItem != null)
                  StatusWidget(
                    title: widget.subItem!.title,
                    subtitle: widget.subItem!.subtitle,
                    margin: const EdgeInsets.only(top: 8),
                    infoCard: true,
                  ),
                if (widget.item.child != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: widget.item.child!,
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  List<TextSpan> _highlightWords() {
    final words = widget.item.title.split(' ');
    final boldWords = ['покупатель', 'продавец'];

    return words.map((word) {
      final isBold = boldWords.contains(word.toLowerCase());
      return TextSpan(
        text: '$word ',
        style: isBold
            ? Theme.of(context).textTheme.headlineSmall
            : Theme.of(context).textTheme.bodyLarge,
      );
    }).toList();
  }

  void calculateTextHeight() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && !widget.item.isLast && timelineHeight == null) {
        final box = textKey.currentContext?.findRenderObject() as RenderBox?;

        setState(() {
          if (box != null) {
            timelineHeight =
                box.size.height / (widget.item.child != null ? 1.5 : 3.3);
          } else {
            timelineHeight = 6;
          }
        });
      }
    });
  }
}
