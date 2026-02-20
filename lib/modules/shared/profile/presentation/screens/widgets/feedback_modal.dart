import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../../../../../components/UI/modal_appbar.dart';
import '../../../../../../components/widgets/buttons/blue_button.dart';
import '../../../../../../components/widgets/snackbar/snackbar.dart';
import '../../../../../../components/widgets/text_field_widget.dart';
import '../../../../../../config/injectable/injectable.dart';
import '../../../../login/domain/user/user_bloc.dart';

class FeedbackModal extends StatefulWidget {
  const FeedbackModal({super.key});

  @override
  State<FeedbackModal> createState() => _FeedbackModalState();
}

class _FeedbackModalState extends State<FeedbackModal> {
  String place = '';
  String comment = '';

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.8,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const ModalAppBar(text: 'Опишите проблему'),
            TextFieldWidget(
              autofocus: true,
              margin: const EdgeInsets.only(bottom: 10),
              labelText: 'Место, где произошла ошибка / Экран',
              onTextChanged: (text) => setState(() => place = text),
            ),
            TextFieldWidget(
              margin: const EdgeInsets.only(bottom: 10),
              maxLines: 3,
              labelText: 'Описание',
              onTextChanged: (text) => setState(() => comment = text),
            ),
            BlueButton(
              text: 'Отправить',
              onPressed: _submitFeedback,
            ),
          ],
        ),
      ),
    );
  }

  void _submitFeedback() async {
    final user = getIt.get<UserBloc>().user;
    if (comment.isNotEmpty && place.isNotEmpty) {
      final test = {
        'login': user?.userLogin,
        'userRole': user?.userRole,
        'place': place,
        'comment': comment,
      }.toString();

      await Sentry.captureMessage(test);

      if (mounted) Navigator.of(context).pop();
    } else {
      showSnackBar(context, 'Заполните поля');
    }
  }
}
