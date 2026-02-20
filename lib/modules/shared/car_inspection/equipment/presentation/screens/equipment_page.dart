import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/injectable/injectable.dart';
import '../../../../../../components/widgets/no_content_widget.dart';
import '../../../../../../components/widgets/page_form_widget.dart';
import '../../../../../../components/widgets/snackbar/snackbar.dart';
import '../../../../_data/models/auto_info.dart';
import '../../domain/equipment/equipment_bloc.dart';
import 'widgets/equipment_content.dart';

class EquipmentPage extends StatefulWidget {
  final AutoInfo? autoInfo;

  const EquipmentPage(this.autoInfo, {super.key});

  @override
  State<EquipmentPage> createState() => _EquipmentPageState();
}

class _EquipmentPageState extends State<EquipmentPage> {
  final bloc = getIt.get<EquipmentBloc>();
  @override
  void initState() {
    if (bloc.equipment == null) {
      load();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageFormWidget(
      appBarTitle: 'Опции и оборудование',
      useParentTitle: true,
      child: BlocProvider.value(
        value: bloc,
        child: BlocConsumer<EquipmentBloc, EquipmentState>(
          listener: (context, state) {
            state.whenOrNull(
              error: (message) => showSnackBar(context, message ?? ''),
              noContent: () => showSnackBar(
                context,
                'Отсутствуют данные об опциях и оборудовании',
              ),
            );
          },
          builder: (context, state) {
            return state.whenOrNull(
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  hasContent: (equipment) {
                    return RefreshIndicator(
                      onRefresh: load,
                      child: EquipmentContent(equipmentMap: equipment!),
                    );
                  },
                ) ??
                NoContentWidget(onRefresh: load);
          },
        ),
      ),
    );
  }

  Future<void> load() async {
    if (widget.autoInfo != null) {
      bloc.add(EquipmentEvent.load(autoInfo: widget.autoInfo));
    }
  }
}
