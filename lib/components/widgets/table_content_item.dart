import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../styles/app_colors.dart';

class TableContentItem extends StatefulWidget {
  final String title;
  final String? value;
  final bool slim;
  final bool caseFormat;

  const TableContentItem({
    required this.title,
    required this.value,
    super.key,
    this.slim = true,
    this.caseFormat = true,
  });

  @override
  State<TableContentItem> createState() => _TableContentItemState();
}

class _TableContentItemState extends State<TableContentItem> {
  List<String> valueItems = [];

  TextStyle? get textStyle => widget.slim
      ? Theme.of(context).textTheme.bodyMedium
      : Theme.of(context).textTheme.bodyLarge;

  @override
  void initState() {
    super.initState();
    if (widget.value!.contains(',')) {
      valueItems = widget.value!.split(', ');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.value == null) {
      return const SizedBox();
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: Text(
                  widget.title,
                  style: textStyle?.copyWith(color: AppColors.inactiveText),
                ),
              ),
              valueItems.isEmpty
                  ? Expanded(
                      child: Text(
                        widget.caseFormat
                            ? toBeginningOfSentenceCase(
                                widget.value!.toLowerCase(),
                              )
                            : widget.value!,
                        style: textStyle,
                      ),
                    )
                  : Expanded(
                      child: Wrap(
                        children: valueItems
                            .map(
                              (item) => Text(
                                '$item\n',
                                style: textStyle,
                              ),
                            )
                            .toList(),
                      ),
                    ),
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }
}
