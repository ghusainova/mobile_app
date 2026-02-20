import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/injectable/injectable.dart';
import '../../../../../../components/widgets/appbar/appbar_widget.dart';
import '../../../../../../components/widgets/container_widget.dart';
import '../../../../../../components/widgets/no_content_widget.dart';
import '../../../../../../components/widgets/snackbar/snackbar.dart';
import '../../../../_data/models/auto_info.dart';
import '../../domain/interior/interior_bloc.dart';
import '../../../shared/presentation/act_info_form.dart';

class InteriorPage extends StatefulWidget {
  final AutoInfo? autoInfo;

  const InteriorPage(this.autoInfo, {super.key});

  @override
  State<InteriorPage> createState() => _InteriorPageState();
}

class _InteriorPageState extends State<InteriorPage> {
  final interiorBloc = getIt.get<InteriorBloc>();

  @override
  void initState() {
    initBloc();
    super.initState();
  }

  @override
  void dispose() {
    interiorBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget('Салон'),
      body: BlocProvider.value(
        value: interiorBloc,
        child: BlocConsumer<InteriorBloc, InteriorState>(
          listener: (context, state) {
            state.whenOrNull(
              error: (message) => showSnackBar(context, message),
            );
          },
          builder: (context, state) {
            return state.whenOrNull(
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  loaded: (actDetailInfo, _) {
                    return RefreshIndicator(
                      onRefresh: onRefresh,
                      child: ContainerWidget(
                        title: 'Салон',
                        child: Expanded(
                          child: ActInfoForm(
                            orderId: widget.autoInfo?.id,
                            actDetailInfo: actDetailInfo,
                          ),
                        ),
                      ),
                    );
                  },
                ) ??
                NoContentWidget(onRefresh: onRefresh);
          },
        ),
      ),
    );
  }

  void initBloc() {
    interiorBloc.add(InteriorEvent.load(widget.autoInfo?.id));
  }

  Future<void> onRefresh() async {
    interiorBloc.add(InteriorEvent.load(widget.autoInfo?.id));
  }
}
