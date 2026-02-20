import 'package:flutter/material.dart';

import '../../../../../../../../components/widgets/buttons/buttons_bar.dart';
import '../../../../../_shared/data/models/defect.dart';
import 'modal_form.dart';

class DefectModal extends StatefulWidget {
  final List<Defect> defects;
  final VoidCallback onReset;
  final void Function(List<Defect>) onSelect;

  const DefectModal({
    required this.defects,
    required this.onReset,
    required this.onSelect,
    super.key,
  });

  @override
  State<DefectModal> createState() => _DefectModalState();
}

class _DefectModalState extends State<DefectModal> {
  List<Defect> updatedDefects = [];

  @override
  void initState() {
    super.initState();
    updatedDefects = widget.defects;
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      //TODO: return dynamic size, but check on lights defects
      heightFactor: 0.95,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: const EdgeInsets.all(0),
              title: Text(
                'Укажите дефекты',
                style: Theme.of(context).textTheme.displayMedium,
              ),
              trailing: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                padding: EdgeInsets.zero,
                icon: const Icon(Icons.close),
              ),
            ),
            if (updatedDefects.isEmpty) const Text('Список пуст'),
            Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: updatedDefects.length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) => DefectModalForm(
                  defect: updatedDefects[index],
                  onChange: onChanged,
                ),
              ),
            ),
            ButtonsBar(
              onClear: () => _onClear(context),
              onConfirm: () => _onConfirm(context),
              padding: const EdgeInsets.all(16),
            ),
          ],
        ),
      ),
    );
  }

  void onChanged(Defect updatedDefect) {
    updatedDefects = updatedDefects
        .map((e) => e.title == updatedDefect.title ? updatedDefect : e)
        .toList();
    setState(() => updatedDefects);
  }

  void _onClear(BuildContext context) {
    widget.onReset();
    Navigator.of(context).pop();
  }

  void _onConfirm(BuildContext context) {
    widget.onSelect(updatedDefects);
    Navigator.of(context).pop();
  }
}
