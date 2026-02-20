import 'package:flutter/material.dart';

import '../../styles/app_colors.dart';

class SegmentedControlWidget extends StatefulWidget {
  final List<String> segments;
  final void Function(String selectedSegment) onChange;

  const SegmentedControlWidget({
    required this.segments, required this.onChange, super.key,
  });

  @override
  State<SegmentedControlWidget> createState() => _SegmentedControlWidgetState();
}

class _SegmentedControlWidgetState extends State<SegmentedControlWidget> {
  late final List<ButtonSegment<String>> segments;
  late Set<String> selectedItems;

  @override
  void initState() {
    super.initState();
    mapSegments();
  }

  bool get isSelected =>
      segments.any((element) => selectedItems.contains(element.value));

  @override
  Widget build(BuildContext context) {
    if (widget.segments.isEmpty) {
      return const SizedBox();
    }

    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: AppColors.backBase,
        borderRadius: BorderRadius.circular(12),
      ),
      child: SegmentedButton(
        segments: segments,
        selected: selectedItems,
        showSelectedIcon: false,
        style: TextButton.styleFrom(
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          textStyle: Theme.of(context).textTheme.bodyMedium,
        ),
        onSelectionChanged: (sets) {
          setState(() => selectedItems = sets);
          widget.onChange(selectedItems.first);
        },
      ),
    );
  }

  void mapSegments() {
    if (widget.segments.isNotEmpty) {
      segments = widget.segments
          .map((e) => ButtonSegment(
                value: e,
                label: Text(e, textAlign: TextAlign.center),
              ),)
          .toList();
      selectedItems = {widget.segments.first};
    }
  }
}
