import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../components/widgets/buttons/blue_button.dart';
import '../../../../../../components/widgets/page_form_widget.dart';
import '../../../../../../components/widgets/text_field_widget.dart';
import '../../../../../credit_manager/seller_data/presentation/widgets/car_not_found_modal.dart';
import '../../../domain/bloc/queue_bloc.dart';

class CallClientByIinPage extends StatefulWidget {
  const CallClientByIinPage({super.key});

  @override
  State<CallClientByIinPage> createState() => _CallClientByIinPageState();
}

class _CallClientByIinPageState extends State<CallClientByIinPage> {
  final textController = TextEditingController();
  final textFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageFormWidget(
      appBarTitle: 'Вызвать по номеру талона или ИИН',
      useParentTitle: true,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Form(
            key: textFormKey,
            child: TextFieldWidget(
              textController: textController,
              labelText: 'Номер талона или ИИН покупателя',
              keyboardType: TextInputType.number,
              onValidate: onValidate,
            ),
          ),
        ),
        BlocConsumer<QueueBloc, QueueState>(
          listener: (context, state) => state.whenOrNull(
            handlingClient: (_) => context.pop(),
            error: (_, __) => showDialogWidget(),
          ),
          builder: (context, state) => Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: BlueButton(
                text: 'Вызвать',
                isLoading: state is Loading,
                onPressed: callClientByIin,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void callClientByIin() {
    final iin = textController.text;

    FocusScope.of(context).unfocus();
    textFormKey.currentState?.validate();

    if (iin.isEmpty) {
      return;
    }

    context.read<QueueBloc>().add(CallClient(iin: iin));
  }

  String? onValidate(String? value) {
    final text = value ?? '';
    final isValidated = text.isEmpty || !RegExp(r'^[0-9]').hasMatch(text);

    if (isValidated) {
      return 'Введите номер талона или ИИН покупателя';
    }

    return null;
  }

  void showDialogWidget() {
    showDialog(
      context: context,
      builder: (_) => const CarNotFoundModal('Клиент не найден'),
    );
  }
}
