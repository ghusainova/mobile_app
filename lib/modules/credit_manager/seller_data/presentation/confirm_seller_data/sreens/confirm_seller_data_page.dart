import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../components/router/data/routes.dart';
import '../../../../../../components/widgets/no_content_widget.dart';
import '../../../../../../components/widgets/page_form_widget.dart';
import '../../../../../../components/widgets/snackbar/snackbar.dart';
import '../../../../../../config/injectable/injectable.dart';
import '../../../../credit_application/domain/credit_application/credit_application_bloc.dart'
    as acb;
import '../../../data/constants/confirm_seller_const.dart';
import '../../../domain/bloc/seller_data_bloc.dart';
import '../../widgets/car_not_found_modal.dart';
import 'widgets/seller_car_info_widget.dart';

class ConfirmSellerDataPage extends StatefulWidget {
  const ConfirmSellerDataPage({super.key});

  @override
  State<ConfirmSellerDataPage> createState() => _ConfirmSellerDataPageState();
}

class _ConfirmSellerDataPageState extends State<ConfirmSellerDataPage> {
  @override
  void initState() {
    loadApplicationData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageFormWidget(
      appBarTitle: 'Данные продавца и авто',
      child: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: getIt.get<SellerDataBloc>()),
          BlocProvider.value(value: getIt.get<acb.CreditApplicationBloc>()),
        ],
        child: BlocListener<SellerDataBloc, SellerDataState>(
          listener: (context, state) => state.whenOrNull(
            confirmed: () => _onConfirm(context),
            error: showError,
          ),
          child: BlocBuilder<acb.CreditApplicationBloc,
              acb.CreditApplicationState>(
            bloc: getIt.get<acb.CreditApplicationBloc>(),
            builder: (context, carLoanState) =>
                carLoanState.whenOrNull(
                  loaded: (carLoanOrder) => RefreshIndicator(
                    onRefresh: loadApplicationData,
                    child: SellerCarInfoWidget(creditApplication: carLoanOrder),
                  ),
                  noContent: (message) =>
                      NoContentWidget(onRefresh: loadApplicationData),
                ) ??
                const Center(child: CircularProgressIndicator()),
          ),
        ),
      ),
    );
  }

  void _onConfirm(BuildContext context) {
    StatusPageRoute(ConfirmSellerConst.buyerNeedToConfirm).go(context);
  }

  Future<void> loadApplicationData() async {
    getIt.get<acb.CreditApplicationBloc>().add(
          const acb.CreditApplicationEvent.getCreditApplicationOrder(
            getStatusList: false,
          ),
        );
  }

  void showError(String? message, bool? showModal) {
    if (showModal == true) {
      showDialog(context: context, builder: (_) => CarNotFoundModal(message));
    } else {
      showSnackBar(context, message);
    }
  }
}
