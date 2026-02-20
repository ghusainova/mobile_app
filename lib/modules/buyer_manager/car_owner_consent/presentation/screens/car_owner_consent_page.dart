import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/injectable/injectable.dart';
import '../../../../../components/router/data/routes.dart';
import '../../../../../components/widgets/buttons/blue_button.dart';
import '../../../../../components/widgets/status_widget.dart';
import '../../../../../components/widgets/page_form_widget.dart';
import '../../../../../components/widgets/text_field_widget.dart';
import '../../../../shared/_data/enums/status_type_enum.dart';
import '../../data/constants/status_constants.dart';
import '../../domain/bloc/car_owner_consent_bloc.dart';

class CarOwnerConsentPage extends StatefulWidget {
  const CarOwnerConsentPage({super.key});

  @override
  State<CarOwnerConsentPage> createState() => _CarOwnerConsentPageState();
}

class _CarOwnerConsentPageState extends State<CarOwnerConsentPage> {
  TextEditingController iin = TextEditingController();
  final bloc = getIt.get<CarOwnerConsentBloc>();
  String? errorText;

  @override
  void dispose() {
    iin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: BlocConsumer<CarOwnerConsentBloc, CarOwnerConsentState>(
        listener: (context, state) {
          state.whenOrNull(
            sent: () => StatusPageRoute(carOwnerConsentConfigs).go(context),
          );
        },
        builder: (context, state) {
          return PageFormWidget(
            appBarTitle: 'Согласие владельца авто',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Введите ИИН владельца авто',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    'Мы отправим владельцу авто сообщение в Kaspi.kz для получения согласия на сбор и обработку персональных данных',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 4),
                  child: TextFieldWidget(
                    digitsOnly: true,
                    keyboardType: TextInputType.number,
                    labelText: 'ИИН владельца авто',
                    textController: iin,
                    errorText: errorText,
                    onTextChanged: (_) => onValidate,
                  ),
                ),
                if (state is Error && state.message != null)
                  StatusWidget(
                    status: StatusTypeEnum.warning,
                    title: 'Данные авто не найдены',
                    subtitle: state.message!,
                    infoCard: true,
                  ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: BlueButton(
                      isLoading: state is Loading,
                      text: 'Отправить сообщение в Kaspi.kz',
                      onPressed: () => validateAndSend(),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void validateAndSend() {
    if (iin.text.isEmpty) {
      setErrorrMessage();
      return;
    }

    sendSms();
  }

  void sendSms() {
    bloc.add(CarOwnerConsentEvent.getCarOwnerConsent(iin.text));
  }

  void onValidate() {
    if (iin.text.isEmpty) {
      setErrorrMessage();
    }
  }

  void setErrorrMessage() {
    setState(() {
      errorText = 'Заполните иин владельца авто';
    });
  }
}
