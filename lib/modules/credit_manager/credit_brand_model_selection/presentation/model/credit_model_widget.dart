import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../../config/injectable/injectable.dart';
import '../../../../../components/UI/model_app_bar.dart';
import '../../../../../components/widgets/no_content_widget.dart';
import '../../../../shared/brand_model_selection/presentation/model/content_type/single_choice_model.dart';
import '../../domain/credit_model/credit_model_bloc.dart';

class CreditModelWidget extends StatefulWidget {
  final String selectedBrand;
  final String? year;

  const CreditModelWidget({
    super.key,
    required this.selectedBrand,
    this.year,
  });

  @override
  State<CreditModelWidget> createState() => _CreditModelWidgetState();
}

class _CreditModelWidgetState extends State<CreditModelWidget> {
  List<String>? selectedModelsList;
  String? selectedModel;

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
            ModelAppBar(brand: widget.selectedBrand),
            BlocProvider.value(
              value: getIt.get<CreditModelBloc>(),
              child: Expanded(
                child: BlocBuilder<CreditModelBloc, CreditModelState>(
                  builder: (context, state) => state.when(
                    initial: () => const SizedBox(),
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    loaded: (models) {
                      return SingleChoiceModel(
                        models: models,
                        selectedModel: selectedModel,
                        onSelect: (value) => onSelect(value: value),
                      );
                    },
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
    getIt.get<CreditModelBloc>().add(
          CreditModelEvent.load(widget.selectedBrand),
        );
  }

  void onSelect({
    List<String>? valuesList,
    String? value,
    bool isSubmit = true,
  }) {
    if ((value ?? '').isNotEmpty) {
      selectedModel = value;
    }

    context.pop(selectedModel);
  }
}
