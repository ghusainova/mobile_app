import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../components/router/data/routes.dart';
import '../../../../../../../components/widgets/buttons/blue_button.dart';
import '../../../../../../../components/widgets/snackbar/snackbar.dart';
import '../../../../../../../components/widgets/text_field_read_only.dart';
import '../../../../../../../components/widgets/text_field_widget.dart';
import '../../../../../../../config/injectable/injectable.dart';
import '../../../../../../shared/_data/constants/global_constants.dart';
import '../../../../../credit_application/data/models/credit_application_auto.dart';
import '../../../../../credit_application/domain/credit_application/credit_application_bloc.dart'
    as cab;
import '../../../../../credit_brand_model_selection/presentation/credit_brand_model_selection.dart';
import '../../../../data/constants/confirm_seller_const.dart';
import '../../../../data/models/brand_model_request_body/brand_model_request_body.dart';
import '../../../../domain/bloc/seller_data_bloc.dart';
import '../../../widgets/car_not_found_modal.dart';

class SellerDataInputFieldsWidget extends StatefulWidget {
  const SellerDataInputFieldsWidget({super.key});

  @override
  State<SellerDataInputFieldsWidget> createState() =>
      _SellerDataInputFieldsWidgetState();
}

class _SellerDataInputFieldsWidgetState
    extends State<SellerDataInputFieldsWidget> {
  CreditApplicationAuto? auto;
  String? brand, model, bodyNumber;

  @override
  void initState() {
    super.initState();
    initData();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFieldReadOnly(
          initialText: brand,
          labelText: Constants.brandAuto,
          helperText: (auto?.brandMVD != null && auto?.brandMVD != '')
              ? '${Constants.brandAuto} из МВД ${auto?.brandMVD}'
              : null,
          margin: const EdgeInsets.only(top: 24, bottom: 20),
          onTap: selectBrandResponse,
        ),
        TextFieldReadOnly(
          initialText: model,
          labelText: Constants.modelAuto,
          helperText: (auto?.modelMVD != null && auto?.modelMVD != '')
              ? '${Constants.modelAuto} из МВД ${auto?.modelMVD}'
              : null,
          margin: const EdgeInsets.only(bottom: 20),
          onTap: selectModelResponse,
        ),
        TextFieldWidget(
          initialText: bodyNumber,
          margin: const EdgeInsets.only(bottom: 8),
          labelText: 'Номер кузова',
          onTextChanged: (text) => setState(() => bodyNumber = text),
        ),
        BlocConsumer<SellerDataBloc, SellerDataState>(
          listener: (context, state) => state.whenOrNull(
            confirmed: () => const ConfirmSellerDataRoute().push(context),
            denied: () => StatusPageRoute(
              ConfirmSellerConst.carCreditUnavailable,
            ).go(context),
            error: (message, showModal) => showError(
              message: message,
              showModal: showModal,
            ),
          ),
          builder: (context, state) => Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: BlueButton(
                isLoading: state is Loading,
                onPressed: onContinue,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void initData() {
    auto = getIt.get<cab.CreditApplicationBloc>().carLoanOrder?.auto;
    brand = auto?.brand;
    model = auto?.model;
    bodyNumber = auto?.bodyNumber;
  }

  Future<void> selectBrandResponse() async {
    final response = await selectBrand(context, isRadioButton: true);

    if (response != null && response != '') {
      setState(() => brand = response);
    }
  }

  Future<void> selectModelResponse() async {
    if (brand != null) {
      final response = await selectModel(context, brand!, year: auto?.year);

      if (response != null && response != '') {
        setState(() => model = response);
      }
    } else {
      showSnackBar(context, 'Выберите марку');
    }
  }

  void onContinue() {
    final autoBrandModel = AutoBrandModel(
      brand: brand ?? '',
      model: model ?? '',
      bodyNumber: bodyNumber ?? '',
    );

    if (autoBrandModel.isEmpty) {
      showSnackBar(context, 'Заполните данные');
      return;
    }

    getIt.get<SellerDataBloc>().add(SaveBrandModel(autoBrandModel));
  }

  void showError({String? message, bool? showModal}) {
    if (message == null) {
      showSnackBar(context, 'Не удалось сохранить данные!');
    } else if (showModal == true) {
      showDialog(context: context, builder: (_) => CarNotFoundModal(message));
    } else {
      showSnackBar(context, message);
    }
  }
}
