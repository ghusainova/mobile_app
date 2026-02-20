import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/injectable/injectable.dart';
import '../../../../catalog/presentation/widgets/catalog_list_widget.dart';
import '../../../../../../components/widgets/card_widget/card_widget.dart';
import '../../../../../../components/widgets/horizontal_card_list_widget/horizontal_card_list_widget.dart';
import '../../../domain/recommended_autos/recommended_autos_bloc.dart';

class RecommendedAutosWidget extends StatefulWidget {
  final bool forceInit;
  final bool horizontalList;

  const RecommendedAutosWidget({
    super.key,
    this.forceInit = false,
    this.horizontalList = true,
  });

  @override
  State<RecommendedAutosWidget> createState() => _RecommendedAutosWidgetState();
}

class _RecommendedAutosWidgetState extends State<RecommendedAutosWidget> {
  @override
  void initState() {
    super.initState();
    initBloc();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt.get<RecommendedAutosBloc>(),
      child: BlocBuilder<RecommendedAutosBloc, RecommendedAutosState>(
        builder: (context, state) =>
            state.whenOrNull(
              hasContent: (recommendedList) => CardWidget(
                title: 'Рекомендованные авто',
                margin: const EdgeInsets.only(bottom: 16),
                contentPadding: EdgeInsets.zero,
                child: widget.horizontalList
                    ? HorizontalCardListWidget(orders: recommendedList)
                    : CatalogListWidget(
                        catalogResponse: recommendedList,
                        updateOnScroll: false,
                      ),
              ),
            ) ??
            const SizedBox(),
      ),
    );
  }

  void initBloc() {
    if (widget.forceInit) {
      getIt.get<RecommendedAutosBloc>().add(const GetRecommendedAutos());
    }
  }
}
