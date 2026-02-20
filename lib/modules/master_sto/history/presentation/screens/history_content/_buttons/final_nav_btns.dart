import 'package:flutter/material.dart';

import '../../../../../../../components/widgets/buttons/blue_button.dart';
import '../../../../../../../components/widgets/text_field_widget.dart';
import '../../../../../../../config/injectable/injectable.dart';
import '../../../../domain/history/history_bloc.dart';

class FinalNavBtns extends StatefulWidget {
  const FinalNavBtns({super.key});

  @override
  State<FinalNavBtns> createState() => _FinalNavBtnsState();
}

class _FinalNavBtnsState extends State<FinalNavBtns> {
  final commentController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextFieldWidget(
            labelText: 'Комментарии по осмотру авто',
            textController: commentController,
            maxLines: 3,
          ),
          BlueButton(
            text: 'Подтвердить и завершить осмотр',
            margin: const EdgeInsets.only(top: 16, bottom: 48),
            isLoading: getIt.get<HistoryBloc>().state is Loading,
            onPressed: _completeWork,
          ),
        ],
      ),
    );
  }

  void _completeWork() {
    getIt
        .get<HistoryBloc>()
        .add(HistoryEvent.finish(comment: commentController.text));
  }
}
