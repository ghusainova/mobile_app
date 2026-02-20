import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../components/widgets/buttons/buttons_bar.dart';
import '../../../../../../components/widgets/text_field_widget.dart';
import '../../../data/models/main_info.dart';
import '../../../../../../components/widgets/switch_list_tile.dart';

class MileageModal extends StatefulWidget {
  final MainInfo mainInfo;
  final void Function(String mileage) onSubmit;

  const MileageModal({
    required this.mainInfo,
    required this.onSubmit,
    super.key,
  });

  @override
  State<MileageModal> createState() => _MileageModalState();
}

class _MileageModalState extends State<MileageModal> {
  final controller = TextEditingController();
  bool mileageSwitcher = false;

  @override
  void initState() {
    super.initState();
    controller.text = widget.mainInfo.mileage;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.7,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Text(
              'Укажите пробег',
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
          TextFieldWidget(
            autofocus: true,
            keyboardType: TextInputType.number,
            textController: controller,
            labelText: mileageSwitcher ? 'миль' : 'км',
          ),
          AppSwitchListTile(
            text: 'Пробег в милях',
            switchValue: mileageSwitcher,
            onChanged: (value) => setState(() => mileageSwitcher = value),
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: Text(
              'Введенный пробег в милях автоматически сконвертируется в километры после применения',
            ),
          ),
          ButtonsBar(onClear: onClear, onConfirm: onConfirm),
        ],
      ),
    );
  }

  void onClear() {
    controller.text = '';
    save();

    context.pop();
  }

  void onConfirm() {
    if (mileageSwitcher) {
      setState(() {
        final mileValue = (double.parse(controller.text) * 1.60934399).toInt();
        controller.text = mileValue.toString();
      });
    }

    save();
    context.pop();
  }

  void save() {
    widget.onSubmit(controller.text);
  }
}
