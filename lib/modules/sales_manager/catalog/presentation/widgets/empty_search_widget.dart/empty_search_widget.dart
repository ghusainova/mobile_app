import 'package:flutter/material.dart';

import '../../../../client_processing/presentation/screens/handling_client/recommended_autos_widget.dart';
import 'filter_plug_widget.dart';

class EmptyCatalogWidget extends StatelessWidget {
  const EmptyCatalogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            FilterPlugWidget(),
            RecommendedAutosWidget(forceInit: true, horizontalList: false),
          ],
        ),
      ),
    );
  }
}
