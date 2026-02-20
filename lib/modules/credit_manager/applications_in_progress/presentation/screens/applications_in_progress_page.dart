import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../components/widgets/appbar/appbar_widget.dart';
import '../../../../../components/widgets/no_content_widget.dart';
import '../../../../../config/injectable/injectable.dart';
import '../../domain/applications_in_progress/applications_in_progress_bloc.dart';
import 'widgets/applications_in_progress_content.dart';

class ApplicationsInProgressPage extends StatefulWidget {
  const ApplicationsInProgressPage({super.key});

  @override
  State<ApplicationsInProgressPage> createState() =>
      _ApplicationsInProgressPageState();
}

class _ApplicationsInProgressPageState
    extends State<ApplicationsInProgressPage> {
  final bloc = getIt.get<ApplicationsInProgressBloc>();

  @override
  void initState() {
    load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(null, showBackButton: false),
      body: BlocProvider.value(
        value: bloc,
        child: BlocBuilder<ApplicationsInProgressBloc,
            ApplicationsInProgressState>(
          builder: (context, state) => state.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            loaded: (creditApplicationList) => RefreshIndicator(
              onRefresh: load,
              child: ApplicationsInProgressContent(
                creditApplicationList: creditApplicationList,
              ),
            ),
            error: (message) => NoContentWidget(
              onRefresh: load,
              errorMessage: message,
            ),
            noContent: () => NoContentWidget(onRefresh: load),
          ),
        ),
      ),
    );
  }

  Future<void> load() async {
    bloc.add(const ApplicationsInProgressEvent.load());
  }
}
