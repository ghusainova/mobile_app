import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/injectable/injectable.dart';
import '../../../../../components/widgets/appbar/appbar_widget.dart';
import '../../../../../components/widgets/snackbar/snackbar.dart';
import '../../../../shared/_data/models/auto_info.dart';
import '../../domain/auto_detail/auto_detail_bloc.dart';
import 'widgets/auto_detail_content.dart';

class AutoDetailPage extends StatefulWidget {
  final AutoInfo autoInfo;
  final bool fromApprovedCredit;

  const AutoDetailPage({
    required this.autoInfo,
    super.key,
    this.fromApprovedCredit = false,
  });

  @override
  State<AutoDetailPage> createState() => _AutoDetailPageState();
}

class _AutoDetailPageState extends State<AutoDetailPage> {
  final autoDetailBloc = getIt.get<AutoDetailBloc>();

  @override
  void initState() {
    super.initState();
    autoDetailBloc.add(AutoDetailEvent.load(autoInfo: widget.autoInfo));
  }

  @override
  void dispose() {
    autoDetailBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        '${widget.autoInfo.auto?.brand ?? ''} ${widget.autoInfo.auto?.model ?? ''}, ${widget.autoInfo.auto?.year ?? ''}'
            .trim(),
      ),
      body: BlocProvider.value(
        value: autoDetailBloc,
        child: BlocConsumer<AutoDetailBloc, AutoDetailState>(
          listener: (context, state) => state.whenOrNull(error: onError),
          builder: (context, state) {
            if (state is Loaded) {
              return RefreshIndicator(
                onRefresh: onRefresh,
                child: AutoDetailContent(
                  fromApprovedCredit: widget.fromApprovedCredit,
                ),
              );
            }

            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  Future<void> onRefresh() async {
    autoDetailBloc.add(const AutoDetailEvent.reload());
  }

  void onError(String? message) {
    showSnackBar(context, message ?? 'Ошибка');
  }
}
