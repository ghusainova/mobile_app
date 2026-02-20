import 'package:flutter/material.dart';

import '../widgets/buttons/icon_button_widget.dart';
import '../widgets/text_field_widget.dart';

class SearchBarWidget extends StatefulWidget {
  final String? labelText;
  final String? initialText;
  final bool searchOnEachTap;
  final void Function(String text) onSearch;

  const SearchBarWidget({
    required this.onSearch,
    super.key,
    this.labelText,
    this.initialText,
    this.searchOnEachTap = false,
  });

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.initialText ?? '';
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: TextFieldWidget(
        labelText: widget.labelText ?? 'Поиск авто',
        textController: _controller,
        contenPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        prefixIcon: const Icon(Icons.search, color: Colors.grey),
        suffixIcon: _controller.text.isNotEmpty
            ? IconButtonWidget(
                icon: const Icon(Icons.close),
                onTap: () => _onSearch(context, null),
              )
            : null,
        onTextChanged: (text) => (widget.searchOnEachTap)
            ? _onSearch(
                context,
                text,
                unfocus: false,
              )
            : null,
        onEditingComplete: (text) => _onSearch(context, text),
      ),
    );
  }

  void _onSearch(BuildContext context, String? text, {bool unfocus = true}) {
    if (unfocus) FocusScope.of(context).unfocus();
    widget.onSearch(text ?? '');

    if ((text ?? '').isEmpty) {
      _controller.text = '';
    }
  }
}
