import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/injectable/injectable.dart';
import '../../../../../../components/styles/app_colors.dart';
import '../../../../../../components/widgets/appbar/appbar_widget.dart';
import '../../../../../../components/widgets/no_content_widget.dart';
import '../../../../../../components/widgets/snackbar/snackbar.dart';
import '../../../../shared/_helpers/appbar_back_btn_dialog.dart';
import '../../domain/defects_map/defects_map_bloc.dart';
import 'widgets/defects_map_content.dart';

class DefectsMapPage extends StatefulWidget {
  const DefectsMapPage({super.key});

  @override
  State<DefectsMapPage> createState() => _DefectsMapPageState();
}

class _DefectsMapPageState extends State<DefectsMapPage> {
  final bloc = getIt.get<DefectsMapBloc>();

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
    return Scaffold(
      appBar: AppBarWidget(
        'Осмотр кузова',
        onCloseBtnTap: () => onCloseBtnDialog(context),
      ),
      backgroundColor: AppColors.backBase,
      body: BlocProvider.value(
        value: bloc,
        child: BlocConsumer<DefectsMapBloc, DefectsMapState>(
          listener: (context, state) => state.whenOrNull(
            error: (message) => showSnackBar(context, message ?? ''),
          ),
          builder: (context, state) =>
              state.whenOrNull(
                loading: () => const Center(child: CircularProgressIndicator()),
                loaded: (defectList) => RefreshIndicator(
                  onRefresh: load,
                  child: DefectMapContent(defectList: defectList),
                ),
                error: (message) => NoContentWidget(
                  errorMessage: message,
                  onRefresh: load,
                ),
              ) ??
              const SizedBox(),
        ),
      ),
    );
  }

  Future<void> load() async {
    bloc.add(const DefectsMapEvent.load());
  }
}
