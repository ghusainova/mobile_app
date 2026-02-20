import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../components/router/data/routes.dart';
import '../../../../../components/widgets/buttons/blue_button.dart';
import '../../../../../config/injectable/injectable.dart';
import '../../../../../components/widgets/no_content_widget.dart';
import '../../../../../components/widgets/page_form_widget.dart';
import '../../../../../components/widgets/snackbar/snackbar.dart';
import '../../domain/credit_documents/credit_documents_bloc.dart';
import 'widgets/credit_documents_content.dart';

class CreditDocumentsPage extends StatefulWidget {
  const CreditDocumentsPage({super.key});

  @override
  State<CreditDocumentsPage> createState() => _CreditDocumentsPageState();
}

class _CreditDocumentsPageState extends State<CreditDocumentsPage> {
  final bloc = getIt.get<CreditDocumentsBloc>();

  @override
  void initState() {
    super.initState();
    load();
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageFormWidget(
      appBarTitle: 'Документы',
      pageTitle: 'Распечатайте документы для СпецЦона',
      showAppBarUserData: false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BlocProvider.value(
            value: bloc,
            child: BlocConsumer<CreditDocumentsBloc, CreditDocumentsState>(
              listener: (context, state) {
                state.whenOrNull(
                  error: (message) => showSnackBar(context, message ?? ''),
                );
              },
              builder: (context, state) => state.when(
                loading: () => const Center(child: LinearProgressIndicator()),
                loaded: (creditDocs) =>
                    CreditDocumentsContent(creditDocs.documentBase64),
                error: (errorMessage) => NoContentWidget(
                  onRefresh: load,
                  errorMessage: errorMessage,
                ),
              ),
            ),
          ),
          BlueButton(onPressed: onSubmit),
        ],
      ),
    );
  }

  void load() {
    bloc.add(const CreditDocumentsEvent.load());
  }

  void onSubmit() {
    const CreditApplicationRoute().go(context);
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => showSnackBar(context, 'Документы распечатаны'),
    );
  }
}
