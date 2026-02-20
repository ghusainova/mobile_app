import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../components/widgets/appbar/appbar_widget.dart';
import '../../../../../components/widgets/no_content_widget.dart';
import '../../../../../config/injectable/injectable.dart';
import '../../domain/credit_rework/credit_rework_bloc.dart';
import 'widgets/credit_rework_content.dart';

class CreditReworkPage extends StatefulWidget {
  const CreditReworkPage({super.key});

  @override
  State<CreditReworkPage> createState() => _CreditReworkPageState();
}

class _CreditReworkPageState extends State<CreditReworkPage> {
  final bloc = getIt.get<CreditReworkBloc>();

  @override
  void initState() {
    load();
    super.initState();
  }

  @override
  void dispose() {
    bloc.add(const Reset());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget('Доработки'),
      body: BlocProvider.value(
        value: bloc,
        child: BlocBuilder<CreditReworkBloc, CreditReworkState>(
          builder: (context, state) {
            return state.whenOrNull(
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (message) => NoContentWidget(
                    onRefresh: load,
                    errorMessage: message,
                  ),
                  loaded: (creditReworkItems) =>
                      CreditReworkContent(creditReworkModel: creditReworkItems),
                ) ??
                const SizedBox();
          },
        ),
      ),
    );
  }

  void load() {
    bloc.add(const CreditReworkEvent.load());
  }
}
