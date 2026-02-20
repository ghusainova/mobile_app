import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../components/router/data/routes.dart';
import '../../../../../../components/styles/app_assets.dart';
import '../../../../../../components/widgets/appbar/appbar_widget.dart';
import '../../../../../../components/widgets/buttons/blue_button.dart';
import '../../../../../../components/widgets/qr_view_widget.dart';
import '../../../../../../components/widgets/snackbar/snackbar.dart';
import '../../../../../../config/injectable/injectable.dart';
import '../../../../credit_application/domain/credit_application/credit_application_bloc.dart'
    as acl;
import '../../../data/constants/confirm_seller_const.dart';
import '../../../domain/bloc/seller_data_bloc.dart';
import '../../widgets/car_not_found_modal.dart';

class GetSellerDataPage extends StatefulWidget {
  const GetSellerDataPage({super.key});

  @override
  State<GetSellerDataPage> createState() => _GetSellerDataPageState();
}

class _GetSellerDataPageState extends State<GetSellerDataPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget('Данные продавца и авто'),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            QrViewVidget(
              advertLink: getQrLink(),
              title: 'Получите данные продавца и авто',
              subtitle: 'Попросите продавца авто сканировать Kaspi QR',
              logoPath: AppAssets.kaspiLogo,
            ),
            BlocProvider.value(
              value: getIt.get<SellerDataBloc>(),
              child: BlocConsumer<SellerDataBloc, SellerDataState>(
                listener: (context, state) => state.whenOrNull(
                  denied: () => _onDenied(context),
                  dataIsNotMatched: () => _onDataIsNotMatched(context),
                  gotSellerData: () => _onGotSellerData(context),
                  error: showError,
                ),
                builder: (context, state) => BlueButton(
                  isLoading: state is Loading,
                  onPressed: _navigateToSellerDataCheckup,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onGotSellerData(BuildContext context) {
    const ConfirmSellerDataRoute().push(context);
  }

  void _onDataIsNotMatched(BuildContext context) {
    const EditSellerDataRoute().push(context);
  }

  void _onDenied(BuildContext context) {
    StatusPageRoute(ConfirmSellerConst.carCreditUnavailable).go(context);
  }

  void _navigateToSellerDataCheckup() {
    getIt.get<SellerDataBloc>().add(const GetSellerData());
  }

  String getQrLink() {
    final order = getIt.get<acl.CreditApplicationBloc>().carLoanOrder;
    return 'https://ocess?customerIin=${order?.client.iin}&extId=${order?.order.externalId}';
  }

  void showError(String? message, bool? showModal) {
    if (showModal == true) {
      showDialog(context: context, builder: (_) => CarNotFoundModal(message));
    } else {
      showSnackBar(context, message);
    }
  }
}
