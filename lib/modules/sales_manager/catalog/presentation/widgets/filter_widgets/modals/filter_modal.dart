import 'package:flutter/material.dart';

import '../../../../../../../config/injectable/injectable.dart';
import '../../../../../../shared/_data/constants/global_constants.dart';
import '../../../../../../../modules/shared/brand_model_selection/presentation/brand/brand_modal_widget.dart';
import '../../../../../../../modules/shared/brand_model_selection/presentation/brand_model_selection.dart';
import '../../../../domain/filter_bloc/filter_bloc.dart';
import '../all_filters/all_filters.dart';
import 'lov_modal.dart';
import 'price.dart';

class ChipInfo {
  String label;
  List<String> fields;
  Widget modal;
  bool usePriceFormatter;
  Future<bool> Function(BuildContext context)? onSubmit;

  ChipInfo({
    required this.label,
    required this.fields,
    required this.modal,
    this.usePriceFormatter = false,
    this.onSubmit,
  });
}

List<ChipInfo> horizontalFilterChips = [
  ChipInfo(
    label: 'Все',
    fields: [
      'brand',
      'model',
      'lowerPrice',
      'upperPrice',
      'lowerYear',
      'upperYear',
      'vin',
      'bodyNumber',
      'parkingRow',
      'parkingSlot',
      'transmission',
      'bodyType',
      'drivetrain',
      'mileage',
      'color',
      'engineVolume',
    ],
    modal: const AllFilters(),
  ),
  ChipInfo(
    label: Constants.price,
    fields: ['lowerPrice', 'upperPrice'],
    modal: const PriceModal(),
    usePriceFormatter: true,
  ),
  ChipInfo(
    label: Constants.brandModel,
    fields: ['brand', 'model'],
    modal: const BrandModalWidget(),
    onSubmit: _getBrandModel,
  ),
  ChipInfo(
    label: Constants.engineVolume,
    fields: ['engineVolume'],
    modal: const LovModal(
      title: Constants.engineVolume,
      field: 'engineVolume',
      options: Constants.engineVolumesTypes,
    ),
  ),
  ChipInfo(
    label: Constants.color,
    fields: ['color'],
    modal: const LovModal(
      title: Constants.color,
      field: 'color',
      options: Constants.colorTypes,
    ),
  ),
];

Future<bool?> openFilterModal(
  BuildContext context,
  String label, {
  bool searchAfterSelect = false,
}) async {
  final chipInfo =
      horizontalFilterChips.firstWhere((element) => element.label == label);

  if (chipInfo.onSubmit != null) {
    return await chipInfo.onSubmit!(context);
  }

  return await showModalBottomSheet(
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
    ),
    context: context,
    isScrollControlled: true,
    builder: (context) => chipInfo.modal,
  );
}

Future<bool> _getBrandModel(BuildContext context) async {
  final response = await selectBrandModel(context, multiSelection: true);

  if (response.isMultiResponseNotEmpty) {
    final bloc = getIt.get<FilterBloc>();
    final updatedFilter = bloc.currentFilter.copyWith(
      brand: [...(bloc.currentFilter.brand ?? []), response.brand],
      model: [...(bloc.currentFilter.model ?? []), ...response.modelList],
    );

    bloc.add(SetFilter(updatedFilter));
    return true;
  }

  return false;
}
