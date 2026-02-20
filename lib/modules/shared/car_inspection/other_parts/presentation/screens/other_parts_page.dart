import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/injectable/injectable.dart';
import '../../../../../../components/widgets/no_content_widget.dart';
import '../../../../../../components/widgets/appbar/appbar_widget.dart';
import '../../../../../../components/widgets/container_widget.dart';
import '../../../../../../components/widgets/snackbar/snackbar.dart';
import '../../../../_data/models/auto_info.dart';
import '../../domain/other_parts/other_parts_bloc.dart';
import '../../../shared/presentation/act_info_form.dart';

class OtherPartsPage extends StatefulWidget {
  final AutoInfo? autoInfo;

  const OtherPartsPage(this.autoInfo, {super.key});

  @override
  State<OtherPartsPage> createState() => _OtherPartsPageState();
}

class _OtherPartsPageState extends State<OtherPartsPage> {
  final otherPartsBloc = getIt.get<OtherPartsBloc>();

  @override
  void initState() {
    initBloc();
    super.initState();
  }

  @override
  void dispose() {
    otherPartsBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget('Другие части авто'),
      body: BlocProvider.value(
        value: otherPartsBloc,
        child: BlocConsumer<OtherPartsBloc, OtherPartsState>(
          listener: (context, state) {
            state.whenOrNull(
              error: (message) => showSnackBar(context, message),
            );
          },
          builder: (context, state) {
            return RefreshIndicator(
              onRefresh: onRefresh,
              child: state.whenOrNull(
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    loaded: (otherParts) {
                      return ContainerWidget(
                        title: 'Другие части авто',
                        child: Expanded(
                          child: ActInfoForm(
                            orderId: widget.autoInfo?.id,
                            actDetailInfo: otherParts,
                          ),
                        ),
                      );
                    },
                  ) ??
                  NoContentWidget(onRefresh: onRefresh),
            );
          },
        ),
      ),
    );
  }

  void initBloc() {
    otherPartsBloc.add(OtherPartsEvent.load(widget.autoInfo?.id));
  }

  Future<void> onRefresh() async {
    otherPartsBloc.add(OtherPartsEvent.load(widget.autoInfo?.id));
  }
}
