import 'package:flutter/material.dart';

import '../../../../../../components/widgets/buttons/blue_button.dart';
import '../../../../../../components/widgets/buttons/buttons_bar.dart';
import '../../../../../../components/UI/radio_button_tile/radio_button_tile_widget.dart';
import '../../../../../../components/UI/modal_appbar.dart';

class SingleChoiceLovModal extends StatefulWidget {
  final bool singleButton;
  final String title;
  final String initialValue;
  final List<String> options;
  final void Function(String? selectedValue) onConfirm;

  const SingleChoiceLovModal({
    this.singleButton = false,
    required this.title,
    required this.options,
    required this.initialValue,
    required this.onConfirm,
    super.key,
  });

  @override
  State<SingleChoiceLovModal> createState() => _SingleChoiceLovModalState();
}

class _SingleChoiceLovModalState extends State<SingleChoiceLovModal> {
  String selectedValue = '';

  @override
  void initState() {
    super.initState();
    selectedValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ModalAppBar(text: widget.title),
          if (widget.options.isEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Text(
                'Данных нет',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height / 1.5,
            ),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: widget.options.length,
              itemBuilder: (context, index) => RadioButtonTileWidget(
                title: widget.options[index],
                enabled: selectedValue == widget.options[index],
                onTap: () =>
                    setState(() => selectedValue = widget.options[index]),
              ),
            ),
          ),
          widget.singleButton
              ? BlueButton(
                  text: 'Выбрать',
                  onPressed: () => widget.onConfirm(selectedValue),
                )
              : ButtonsBar(
                  onClear: () => widget.onConfirm(null),
                  onConfirm: () => widget.onConfirm(selectedValue),
                ),
        ],
      ),
    );
  }
}
