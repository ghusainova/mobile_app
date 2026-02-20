import 'package:flutter/material.dart';

import '../../../../../../../../components/widgets/buttons/buttons_bar.dart';
import '../../../../../../../../components/widgets/text_field_widget.dart';
import '../../../../../_shared/data/models/defect_model.dart';
import '../../../../../_shared/data/models/defect_point.dart';

class PointModal extends StatefulWidget {
  final int index;
  final int? microMeter;
  final DefectModel defect;
  final void Function(DefectModel defect) onUpdate;

  const PointModal({
    required this.index,
    required this.defect,
    required this.onUpdate,
    super.key,
    this.microMeter,
  });

  @override
  State<PointModal> createState() => _PointModalState();
}

class _PointModalState extends State<PointModal> {
  final microMeterController = TextEditingController();

  get bloc => null;

  @override
  void initState() {
    super.initState();
    microMeterController.text = widget.microMeter?.toString() ?? '';
  }

  @override
  void dispose() {
    microMeterController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.55,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Text(
              'Укажите толщину краски',
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
          TextFieldWidget(
            contenPadding: const EdgeInsets.symmetric(vertical: 14),
            noFilling: true,
            autofocus: true,
            keyboardType: TextInputType.number,
            digitsOnly: true,
            textController: microMeterController,
            labelText: 'мкм',
            maxLength: 4,
          ),
          ButtonsBar(
            padding: const EdgeInsets.only(top: 16),
            onClear: () => setPoint(clear: true),
            onConfirm: () => setPoint(),
          ),
        ],
      ),
    );
  }

  void setPoint({bool clear = false}) {
    List<DefectPoint>? points = List.of(widget.defect.points ?? []);

    final indexOfEditingPoint = points.indexWhere(
      (DefectPoint point) => point.measuringPoint == widget.index,
    );

    final microMeter = clear ? null : int.tryParse(microMeterController.text);
    final changedPoint = DefectPoint(
      measuringPoint: widget.index,
      micrometer: microMeter,
    );

    if (indexOfEditingPoint >= 0) {
      points[indexOfEditingPoint] = changedPoint;
    } else {
      points.add(changedPoint);
    }
    points.removeWhere(
      (point) => point.micrometer == null,
    );
    widget.onUpdate(widget.defect.copyWith(points: points));
    Navigator.of(context).pop();
  }
}
