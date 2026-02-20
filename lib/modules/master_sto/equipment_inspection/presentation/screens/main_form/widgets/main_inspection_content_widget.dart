import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../../../../../../../services/local_storage/system_options/system_options.dart';
import '../../../../../../../components/widgets/card_widget/card_widget.dart';
import '../../../../../../../config/extensions/string_extensions.dart';
import '../../../../../../../config/injectable/injectable.dart';
import '../../../../data/enum/inspection_item_enum.dart';
import '../../../../data/models/equipment_inspection.dart';
import '../../../../data/models/inspection_item/inspection_item.dart';
import '../../widgets/equipment_checkbox/equipment_checkbox_widget.dart';
import '../../../../domain/equipment_inspection/equipment_inspection_bloc.dart';
import '../../widgets/equipment_content_title_widget.dart';
import '../../../../../../../components/UI/submit_btn_widget.dart';

class MainInspectionContentWidget extends StatefulWidget {
  final InspectionItemEnum inspectionItem;
  final EquipmentInspection equipmentInspection;
  final Future<void> Function() onRefresh;
  final void Function(EquipmentInspection updatedData) onDataUpdated;
  final VoidCallback onSubmit;

  const MainInspectionContentWidget({
    required this.inspectionItem,
    required this.equipmentInspection,
    required this.onRefresh,
    required this.onDataUpdated,
    required this.onSubmit,
    super.key,
  });

  @override
  State<MainInspectionContentWidget> createState() =>
      _MainInspectionContentWidgetState();
}

class _MainInspectionContentWidgetState
    extends State<MainInspectionContentWidget> {
  final autoScrollController = AutoScrollController();
  late EquipmentInspection equipmentInspection;

  bool get isLoading =>
      context.read<EquipmentInspectionBloc>().state is Loading;

  @override
  void initState() {
    super.initState();
    equipmentInspection = widget.equipmentInspection;
    getIt.get<SystemOptions>().firstInitAutoScroll();
  }

  @override
  void dispose() {
    autoScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: widget.onRefresh,
      child: ListView(
        controller: autoScrollController,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        children: [
          EquipmentContentTitleWidget(
            widget.equipmentInspection.name,
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: equipmentInspection.equipments.length,
            itemBuilder: (context, index) {
              final equipmentItem = equipmentInspection.equipments[index];

              if (equipmentItem.isSeatHeatingItemWorkingState &&
                  !equipmentInspection.hasSeatsHeating) {
                return const SizedBox();
              }

              return AutoScrollTag(
                key: ValueKey(index),
                controller: autoScrollController,
                index: index,
                child: CardWidget(
                  title: equipmentItem.name,
                  margin: index == 0
                      ? EdgeInsets.zero
                      : const EdgeInsets.only(top: 16),
                  contentPadding: EdgeInsets.zero,
                  child: EquipmentCheckboxWidget(
                    documentType: widget.inspectionItem.stageName,
                    item: equipmentItem,
                    onChanged: (item) => onChanged(index, item),
                  ),
                ),
              );
            },
          ),
          SubmitBtnWidget(
            onPressed: widget.onSubmit,
            isLoading: isLoading,
          ),
        ],
      ),
    );
  }

  void onChanged(int index, InspectionItem item) {
    autoscroll(index, item.isCompressionCheck);

    if (item.isSeatHeatingSelectionState) {
      equipmentInspection =
          EquipmentInspection.uncheckSeatHeatingValues(equipmentInspection);
    }

    equipmentInspection = EquipmentInspection.updateItems(
      equipmentInspection,
      index,
      item,
    );
    setState(() => equipmentInspection);
    widget.onDataUpdated(equipmentInspection);
  }

  Future<void> autoscroll(int index, bool isCompressionCheck) async {
    if (isCompressionCheck) return;

    final isEnabled = await getIt.get<SystemOptions>().getAutoScrollStatus();

    if (isEnabled.parseBool()) {
      autoScrollController.scrollToIndex(
        index,
        preferPosition: AutoScrollPosition.begin,
      );
    }
  }
}
