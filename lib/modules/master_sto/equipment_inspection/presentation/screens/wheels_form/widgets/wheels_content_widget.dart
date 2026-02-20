import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/enum/inspection_item_enum.dart';
import '../../../../data/models/equipment_inspection.dart';
import '../../widgets/equality_toggle_widget.dart';
import '../../widgets/equipment_content_title_widget.dart';
import '../../../../domain/equipment_inspection/equipment_inspection_bloc.dart';
import '../../../../../../../components/UI/submit_btn_widget.dart';
import 'wheels_type_widget.dart';

class WheelsContentWidget extends StatefulWidget {
  final InspectionItemEnum inspectionItem;
  final EquipmentInspection equipmentInspection;
  final Future<void> Function() onRefresh;
  final void Function(EquipmentInspection updatedData) onDataUpdated;
  final VoidCallback onSubmit;

  const WheelsContentWidget({
    required this.inspectionItem,
    required this.equipmentInspection,
    required this.onRefresh,
    required this.onDataUpdated,
    required this.onSubmit,
    super.key,
  });

  @override
  State<WheelsContentWidget> createState() => _WheelsContentWidgetState();
}

class _WheelsContentWidgetState extends State<WheelsContentWidget> {
  late EquipmentInspection equipmentInspection;
  bool isEqual = true;

  bool get isTiresInspection =>
      widget.inspectionItem == InspectionItemEnum.tires;

  bool get isLoading =>
      context.read<EquipmentInspectionBloc>().state is Loading;

  @override
  void initState() {
    super.initState();
    equipmentInspection = widget.equipmentInspection;
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: widget.onRefresh,
      child: ListView(
        children: [
          EquipmentContentTitleWidget(
            widget.equipmentInspection.name,
          ),
          EqualityToggleWidget(
            isEnabled: isEqual,
            onChanged: (value) => setState(() => isEqual = value),
          ),
          WheelsTypeWidget(
            isTiresInspection: isTiresInspection,
            isEqual: isEqual,
            equipmentInspection: equipmentInspection,
            onChanged: onChanged,
          ),
          SubmitBtnWidget(onPressed: widget.onSubmit, isLoading: isLoading),
        ],
      ),
    );
  }

  void onChanged(EquipmentInspection updatedEquipments) {
    setState(() => equipmentInspection = updatedEquipments);
    widget.onDataUpdated(updatedEquipments);
  }
}
