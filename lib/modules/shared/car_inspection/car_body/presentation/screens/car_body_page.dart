import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/injectable/injectable.dart';
import '../../../../../../components/widgets/appbar/appbar_widget.dart';
import '../../../../../../components/widgets/container_widget.dart';
import '../../../../../../components/widgets/no_content_widget.dart';
import '../../../../../../components/widgets/snackbar/snackbar.dart';
import '../../../../_data/models/auto_info.dart';
import '../../domain/car_body/car_body_bloc.dart';
import 'widgets/defects_map.dart';
import 'widgets/defects_meanings.dart';

class CarBodyPage extends StatefulWidget {
  final AutoInfo? autoInfo;

  const CarBodyPage(this.autoInfo, {super.key});

  @override
  State<CarBodyPage> createState() => _CarBodyPageState();
}

class _CarBodyPageState extends State<CarBodyPage> {
  final carBodyBloc = getIt.get<CarBodyBloc>();

  @override
  void initState() {
    load();
    super.initState();
  }

  @override
  void dispose() {
    carBodyBloc.close();
    super.dispose();
  }

  bool get isBuyout => widget.autoInfo?.method == 'Выкуп авто';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget('Кузов'),
      body: BlocProvider.value(
        value: carBodyBloc,
        child: BlocConsumer<CarBodyBloc, CarBodyState>(
          listener: (context, state) {
            state.whenOrNull(
              error: (message) => showSnackBar(context, message),
            );
          },
          builder: (context, state) =>
              state.whenOrNull(
                loading: () => const Center(child: CircularProgressIndicator()),
                loaded: (defects) {
                  return RefreshIndicator(
                    onRefresh: load,
                    child: ContainerWidget(
                      title: 'Кузов',
                      child: Expanded(
                        child: ListView(
                          scrollDirection: Axis.vertical,
                          padding: const EdgeInsets.all(16),
                          children: [
                            DefectsMeanings(isBuyout: isBuyout),
                            DefectsMap(
                              defects: defects,
                              onTapEnabled: isBuyout,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ) ??
              NoContentWidget(onRefresh: load),
        ),
      ),
    );
  }

  Future<void> load() async {
    carBodyBloc.add(CarBodyEvent.load(widget.autoInfo?.id));
  }
}
