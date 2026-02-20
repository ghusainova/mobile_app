import 'package:flutter/material.dart';

import '../../../../data/enums/branch_user_queue_type_enum.dart';
import '../../../../../queue/data/models/branch_user.dart';
import '../../../../../../../components/UI/radio_button_tile/radio_button_tile_widget.dart';

class CompletingTileItemsWidget extends StatefulWidget {
  final List<BranchUser> users;
  final void Function(int index) onSelect;

  const CompletingTileItemsWidget({
    required this.users,
    required this.onSelect,
    super.key,
  });

  @override
  State<CompletingTileItemsWidget> createState() =>
      _CompletingTileItemsWidgetState();
}

class _CompletingTileItemsWidgetState extends State<CompletingTileItemsWidget> {
  final List<BranchUser> usersList = [];
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    mapList();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RawScrollbar(
        thumbVisibility: true,
        child: ListView(
          children: usersList
              .asMap()
              .entries
              .map(
                (e) => RadioButtonTileWidget(
                  title: e.value.fullname ?? '',
                  subtitle: e.value.tableNumber != null
                      ? 'Стол №${e.value.tableNumber}\n${e.value.queueType?.label ?? ''}'
                      : null,
                  enabled: e.key == selectedIndex,
                  onTap: () => onSelect(e.key),
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  void mapList() {
    usersList.addAll(
      widget.users.where(
        (element) => element.queueType != BranchUserQueueTypeEnum.docsManager,
      ),
    );
  }

  void onSelect(int index) {
    setState(() => selectedIndex = index);
    widget.onSelect(index);
  }
}
