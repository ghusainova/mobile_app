import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/injectable/injectable.dart';
import '../../../../../../components/widgets/card_widget/card_widget.dart';
import '../../../../../../components/widgets/horizontal_card_list_widget/horizontal_card_list_widget.dart';
import '../../../../../../components/widgets/snackbar/snackbar.dart';
import '../../../domain/auto_detail/auto_detail_bloc.dart';
import '../../../domain/similar_auto/similar_auto_bloc.dart';

class SimilarAutoForm extends StatefulWidget {
  const SimilarAutoForm({super.key});

  @override
  State<SimilarAutoForm> createState() => _SimilarAutoFormState();
}

class _SimilarAutoFormState extends State<SimilarAutoForm> {
  final similarCarsBloc = getIt.get<SimilarAutoBloc>();

  @override
  void initState() {
    super.initState();
    initBloc();
  }

  @override
  void dispose() {
    similarCarsBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: similarCarsBloc,
      child: BlocConsumer<SimilarAutoBloc, SimilarAutoState>(
        listener: (context, state) {
          state.whenOrNull(
            error: (message) => showSnackBar(context, message ?? ''),
          );
        },
        builder: (context, state) =>
            state.whenOrNull(
              hasContent: (similarAutoCatalog) {
                return CardWidget(
                  title: 'Похожие авто',
                  margin: const EdgeInsets.only(bottom: 12),
                  contentPadding: EdgeInsets.zero,
                  child: HorizontalCardListWidget(
                    orders: similarAutoCatalog ?? [],
                    pushReplace: true,
                  ),
                );
              },
            ) ??
            const SizedBox(),
      ),
    );
  }

  void initBloc() {
    final autoInfo = context.read<AutoDetailBloc>().autoInfo;
    similarCarsBloc.add(SimilarAutoEvent.load(autoInfo: autoInfo));
  }
}
