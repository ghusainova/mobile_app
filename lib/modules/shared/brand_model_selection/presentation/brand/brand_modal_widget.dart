import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../config/injectable/injectable.dart';
import '../../../_data/constants/global_constants.dart';
import '../../../../../components/widgets/no_content_widget.dart';
import '../../../../../components/UI/modal_appbar.dart';
import '../../domain/brand/brand_bloc.dart';
import 'brand_list_widget.dart';

class BrandModalWidget extends StatefulWidget {
  const BrandModalWidget({super.key});

  @override
  State<BrandModalWidget> createState() => _BrandModalWidgetState();
}

class _BrandModalWidgetState extends State<BrandModalWidget> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.8,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ModalAppBar(text: Constants.brand),
            BlocProvider.value(
              value: getIt.get<BrandBloc>(),
              child: Expanded(
                child: BlocBuilder<BrandBloc, BrandState>(
                  builder: (context, state) => state.when(
                    initial: () => const SizedBox(),
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    loaded: (brands) =>
                        BrandListWidget(brands: brands, onSelect: onSelect),
                    error: (message) => NoContentWidget(onRefresh: loadData),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void loadData() {
    getIt.get<BrandBloc>().add(const BrandEvent.load());
  }

  void onSelect(String selectedBrand) {
    context.pop(selectedBrand);
  }
}
