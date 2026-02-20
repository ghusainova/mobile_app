import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../../config/injectable/injectable.dart';
import '../../../../../components/widgets/buttons/buttons_bar.dart';
import '../../../../../components/widgets/no_content_widget.dart';
import '../../../../../components/UI/model_app_bar.dart';
import '../../domain/model/model_bloc.dart';
import 'content_type/multi_choice_model.dart';
import 'content_type/single_choice_model.dart';

class ModelWidget extends StatefulWidget {
  final String selectedBrand;
  final bool isMultiSelect;

  const ModelWidget({
    required this.selectedBrand,
    required this.isMultiSelect,
    super.key,
  });

  @override
  State<ModelWidget> createState() => _ModelWidgetState();
}

class _ModelWidgetState extends State<ModelWidget> {
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
              value: getIt.get<ModelBloc>(),
              child: Expanded(
                child: BlocBuilder<ModelBloc, ModelState>(
                  builder: (context, state) => state.when(
                    initial: () => const SizedBox(),
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    loaded: (models) {
                      if (widget.isMultiSelect) {
                        return MultiChoiceModel(
                          models: models,
                          selectedModels: selectedModelsList,
                          onSelect: (valuesList) => onSelect(
                            valuesList: valuesList,
                            isSubmit: false,
                          ),
                        );
                      } else {
                        return SingleChoiceModel(
                          models: models,
                          selectedModel: selectedModel,
                          onSelect: (value) => onSelect(value: value),
                        );
                      }
                    },
                    error: (message) => NoContentWidget(onRefresh: loadData),
                  ),
                ),
              ),
            ),
            if (widget.isMultiSelect)
              ButtonsBar(onClear: onSelect, onConfirm: onSelect),
          ],
        ),
      ),
    );
  }

  void loadData() {
    getIt.get<ModelBloc>().add(ModelEvent.load(widget.selectedBrand));
  }

  void onSelect({
    List<String>? valuesList,
    String? value,
    bool isSubmit = true,
  }) {
    if (widget.isMultiSelect) {
      if ((valuesList ?? []).isNotEmpty) {
        selectedModelsList = valuesList;
      }

      if (isSubmit) {
        context.pop(selectedModelsList ?? []);
      }
    } else {
      if ((value ?? '').isNotEmpty) {
        selectedModel = value;
      }

      if ((selectedModel ?? '').isNotEmpty) {
        context.pop([selectedModel!]);
      }
    }
  }
}
