import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/injectable/injectable.dart';
import '../../../../../components/widgets/no_content_widget.dart';
import '../../../../../components/widgets/page_form_widget.dart';
import '../../../../../components/widgets/snackbar/snackbar.dart';
import '../../domain/car_info/car_info_bloc.dart';
import 'widgets/car_info_content.dart';

class CarInfoPage extends StatefulWidget {
  const CarInfoPage({super.key});

  @override
  State<CarInfoPage> createState() => _CarInfoPageState();
}

class _CarInfoPageState extends State<CarInfoPage> {
  final bloc = getIt.get<CarInfoBloc>();
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
      appBarTitle: 'Информация об авто',
      useParentTitle: true,
      child: BlocProvider.value(
        value: bloc,
        child: BlocConsumer<CarInfoBloc, CarInfoState>(
          listener: (context, state) {
            state.whenOrNull(
              error: (message) => showSnackBar(context, message ?? ''),
            );
          },
          builder: (context, state) =>
              state.whenOrNull(
                loaded: (carinfo) => const CarInfoContent(),
                error: (message) => NoContentWidget(
                  onRefresh: load,
                  errorMessage: message,
                ),
              ) ??
              const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }

  void load() {
    bloc.add(const CarInfoEvent.load());
  }
}
