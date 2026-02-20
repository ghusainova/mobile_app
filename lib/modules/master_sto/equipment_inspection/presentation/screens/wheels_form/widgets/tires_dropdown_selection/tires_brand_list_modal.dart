import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../../../config/injectable/injectable.dart';
import '../../../../../domain/tires/tires_bloc.dart';
import 'tires_content_list_widget.dart';
import 'tires_empty_list_widget.dart';

class TiresBrandListModal extends StatelessWidget {
  const TiresBrandListModal({super.key});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.9,
      child: BlocProvider.value(
        value: getIt.get<TiresBloc>(),
        child: BlocBuilder<TiresBloc, TiresState>(
          builder: (context, state) => state.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            loaded: (tires) => TireContentListWidget(
              tireBrands: tires,
              onSelect: (selectedBrand) => context.pop(selectedBrand),
            ),
            noData: (error) => const TireEmptyListWidget(),
          ),
        ),
      ),
    );
  }
}
