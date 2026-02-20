import 'package:flutter/material.dart';

import '../data/model/brand_model_response.dart';
import 'brand/brand_modal_widget.dart';
import 'model/model_widget.dart';

Future<BrandModelResponse> selectBrandModel(
  BuildContext context, {
  bool multiSelection = false,
}) async {
  var brandModelResponse = const BrandModelResponse();
  final selectedBrandResponse = await _selectBrand(context);

  if (context.mounted && selectedBrandResponse.isNotEmpty) {
    final selectedModelResponse = await _selectModel(
      context,
      selectedBrandResponse,
      multiSelection: multiSelection,
    );

    brandModelResponse = _mapBrandModelData(
      selectedBrandResponse,
      selectedModelResponse,
      multiSelection,
    );
  }

  return brandModelResponse;
}

Future<String> _selectBrand(BuildContext context) async {
  return await showModalBottomSheet(
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
        ),
        context: context,
        isScrollControlled: true,
        builder: (context) => const BrandModalWidget(),
      ) ??
      '';
}

Future<List<String>> _selectModel(
  BuildContext context,
  String selectedBrand, {
  bool multiSelection = false,
}) async {
  final response = await showModalBottomSheet(
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
    ),
    context: context,
    isScrollControlled: true,
    builder: (context) => ModelWidget(
      selectedBrand: selectedBrand,
      isMultiSelect: multiSelection,
    ),
  );

  if (response == null) {
    return [];
  }

  return (response as List<String>);
}

BrandModelResponse _mapBrandModelData(
  String brand,
  List<String> models,
  bool isMultiSelect,
) {
  var brandModelResponse = BrandModelResponse(brand: brand);

  if (models.isEmpty) {
    return brandModelResponse;
  }

  if (isMultiSelect) {
    brandModelResponse = brandModelResponse.copyWith(modelList: models);
  } else {
    brandModelResponse = brandModelResponse.copyWith(model: models.first);
  }

  return brandModelResponse;
}
