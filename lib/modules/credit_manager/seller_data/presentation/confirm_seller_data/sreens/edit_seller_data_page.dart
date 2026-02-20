import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../components/widgets/no_content_widget.dart';
import '../../../../../../components/widgets/page_form_widget.dart';
import '../../../../../../components/widgets/snackbar/snackbar.dart';
import '../../../../../../config/injectable/injectable.dart';
import '../../../../credit_application/domain/credit_application/credit_application_bloc.dart';
import '../../../domain/bloc/seller_data_bloc.dart';
import 'widgets/seller_data_input_fields_widget.dart';

class EditSellerDataPage extends StatefulWidget {
  const EditSellerDataPage({super.key});

  @override
  State<EditSellerDataPage> createState() => _EditSellerDataPageState();
}

class _EditSellerDataPageState extends State<EditSellerDataPage> {
  @override
  void initState() {
    super.initState();
    loadApplicationData();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: getIt.get<SellerDataBloc>()),
        BlocProvider.value(value: getIt.get<CreditApplicationBloc>()),
      ],
      child: PageFormWidget(
        appBarTitle: 'Данные авто',
        pageTitle: 'Подойдите к авто и сверьте данные c объявления',
        child: BlocConsumer<CreditApplicationBloc, CreditApplicationState>(
          listener: (context, state) => state.whenOrNull(
            showMessage: (message) => showSnackBar(context, message),
          ),
          builder: (context, state) =>
              state.whenOrNull(
                loading: () => const Center(child: CircularProgressIndicator()),
                noContent: (message) => NoContentWidget(
                  onRefresh: loadApplicationData,
                  errorMessage: message,
                ),
              ) ??
              const SellerDataInputFieldsWidget(),
        ),
      ),
    );
  }

  Future<void> loadApplicationData() async {
    getIt.get<CreditApplicationBloc>().add(
          const CreditApplicationEvent.getCreditApplicationOrder(
            getStatusList: false,
          ),
        );
  }
}
