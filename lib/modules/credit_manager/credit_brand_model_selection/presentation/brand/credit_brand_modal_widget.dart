import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../components/UI/modal_appbar.dart';
import '../../../../../components/UI/search_bar_widget.dart';
import '../../../../../components/widgets/no_content_widget.dart';
import '../../../../../config/injectable/injectable.dart';
import '../../../../shared/_data/constants/global_constants.dart';
import '../../../../shared/brand_model_selection/presentation/model/content_type/single_choice_model.dart';
import '../../domain/credit_brand/credit_brand_bloc.dart';
import 'credit_brand_list_widget.dart';

class CreditBrandWidget extends StatefulWidget {
  final bool isRadioButton;
  const CreditBrandWidget({super.key, required this.isRadioButton});

  @override
  State<CreditBrandWidget> createState() => _CreditBrandWidgetState();
}

class _CreditBrandWidgetState extends State<CreditBrandWidget> {
  List<String> brands = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.9,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16).copyWith(bottom: 0),
            child: const ModalAppBar(text: Constants.brand),
          ),
          SearchBarWidget(
            labelText: 'Поиск',
            initialText: '',
            onSearch: (text) => _onSearch(context, text),
          ),
          BlocProvider.value(
            value: getIt.get<CreditBrandBloc>(),
            child: Expanded(
              child: BlocBuilder<CreditBrandBloc, CreditBrandState>(
                builder: (context, state) => state.when(
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  loaded: (brands) {
                    if (widget.isRadioButton) {
                      return SingleChoiceModel(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        models: brands,
                        selectedModel: '',
                        onSelect: (value) => onSelect(value ?? ''),
                      );
                    }

                    return CreditBrandListWidget(
                      brands: brands,
                      onSelect: onSelect,
                    );
                  },
                  error: (message) => NoContentWidget(onRefresh: loadData),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void loadData() {
    getIt.get<CreditBrandBloc>().add(const CreditBrandEvent.load());
  }

  void onSelect(String selectedBrand) {
    context.pop(selectedBrand);
  }

  _onSearch(BuildContext context, String text) {
    getIt
        .get<CreditBrandBloc>()
        .add(CreditBrandEvent.search(searchValue: text));
  }
}
