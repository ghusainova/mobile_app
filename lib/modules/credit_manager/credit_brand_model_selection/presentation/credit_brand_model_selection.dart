import 'package:flutter/material.dart';

import '../../../shared/brand_model_selection/data/model/brand_model_response.dart';
import 'brand/credit_brand_modal_widget.dart';
import 'model/credit_model_widget.dart';

Future<BrandModelResponse> selectCreditBrandModel(
  BuildContext context, {
  bool multiSelection = false,
  String? year,
}) async {
  var brandModelResponse = const BrandModelResponse();
  final selectedBrandResponse = await selectBrand(context);

  if (context.mounted && selectedBrandResponse.isNotEmpty) {
    final selectedModelResponse = await selectModel(
      context,
      selectedBrandResponse,
      multiSelection: multiSelection,
      year: year,
    );

    brandModelResponse = _mapBrandModelData(
      selectedBrandResponse,
      selectedModelResponse,
      multiSelection,
    );
  }

  return brandModelResponse;
}

Future<dynamic> selectBrand(
  BuildContext context, {
  bool isRadioButton = false,
}) async {
  return await showModalBottomSheet(
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
    ),
    context: context,
    isScrollControlled: true,
    builder: (context) => CreditBrandWidget(isRadioButton: isRadioButton),
  );
}

Future<dynamic> selectModel(
  BuildContext context,
  String selectedBrand, {
  bool multiSelection = false,
  String? year,
}) async {
  return await showModalBottomSheet(
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
    ),
    context: context,
    isScrollControlled: true,
    builder: (context) => CreditModelWidget(
      selectedBrand: selectedBrand,
      year: year,
    ),
  );
}

BrandModelResponse _mapBrandModelData(
  String brand,
  dynamic model,
  bool isMultiSelect,
) {
  var brandModelResponse = const BrandModelResponse();

  if (model == null) {
    return brandModelResponse;
  }

  brandModelResponse = brandModelResponse.copyWith(brand: brand);

  if (isMultiSelect) {
    brandModelResponse = brandModelResponse.copyWith(modelList: model);
  } else {
    brandModelResponse = brandModelResponse.copyWith(model: model);
  }

  return brandModelResponse;
}
