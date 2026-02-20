import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/injectable/injectable.dart';
import '../../../../../components/widgets/no_content_widget.dart';
import '../../../../../components/widgets/page_form_widget.dart';
import '../../../../../components/widgets/snackbar/snackbar.dart';
import '../../../../shared/queue/domain/bloc/queue_bloc.dart';
import '../../../queue/domain/buyout/buyout_bloc.dart';
import '../../data/models/owner_data.dart';
import '../../domain/owner_data/owner_data_bloc.dart';
import 'widgets/owner_data_fields_widget.dart';

class OwnerDataPage extends StatefulWidget {
  const OwnerDataPage({super.key});

  @override
  State<OwnerDataPage> createState() => _OwnerDataPageState();
}

class _OwnerDataPageState extends State<OwnerDataPage> {
  @override
  void initState() {
    super.initState();
    initBloc();
  }

  @override
  Widget build(BuildContext context) {
    return PageFormWidget(
      appBarTitle: 'Данные владельца и авто с госбазы',
      useParentTitle: true,
      child: BlocProvider.value(
        value: getIt.get<OwnerDataBloc>(),
        child: BlocConsumer<OwnerDataBloc, OwnerDataState>(
          listener: (context, state) => state.whenOrNull(
            error: (error) => showSnackBar(context, error),
          ),
          builder: (context, state) =>
              state.whenOrNull(
                loading: () => const Center(child: CircularProgressIndicator()),
                loaded: (OwnerData ownerInfo) =>
                    OwnerDataFieldsWidget(ownerInfo),
                error: (error) =>
                    NoContentWidget(onRefresh: initBloc, errorMessage: error),
              ) ??
              const SizedBox(),
        ),
      ),
    );
  }

  void initBloc() {
    final iin = getIt.get<QueueBloc>().activeClient?.iin;
    final autoInfo = getIt.get<BuyoutBloc>().autoInfo;

    getIt
        .get<OwnerDataBloc>()
        .add(OwnerDataEvent.load(iin: iin, autoInfo: autoInfo));
  }
}
