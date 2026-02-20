import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../../../../config/injectable/injectable.dart';
import '../../../../../components/router/data/routes.dart';
import '../../../scan_cases/domain/scan_cases/scan_cases_bloc.dart';

enum InspectionItemEnum {
  tires,
  rims,
  bodyFrame,
  engine,
  transmission,
  frontInterior,
  rearInterior,
  computerDiagnostics,
  completeness,
  externalLights,
}

extension InspectionItemEnumExt on InspectionItemEnum {
  String get stageName {
    switch (this) {
      case InspectionItemEnum.tires:
        return 'Шины';
      case InspectionItemEnum.rims:
        return 'Диски';
      case InspectionItemEnum.bodyFrame:
        return 'Лонжероны и рамка радиатора';
      case InspectionItemEnum.engine:
        return 'Двигатель';
      case InspectionItemEnum.transmission:
        return 'Трансмиссия';
      case InspectionItemEnum.frontInterior:
        return 'Передняя часть салона';
      case InspectionItemEnum.rearInterior:
        return 'Задняя часть салона';
      case InspectionItemEnum.computerDiagnostics:
        return 'Компьютерная диагностика';
      case InspectionItemEnum.completeness:
        return 'Комплектность';
      case InspectionItemEnum.externalLights:
        return 'Внешние световые приборы';
    }
  }

  String get type {
    switch (this) {
      case InspectionItemEnum.tires:
        return 'Осмотрите установленные шины';
      case InspectionItemEnum.rims:
        return 'Осмотрите установленные диски';
      case InspectionItemEnum.bodyFrame:
        return 'Осмотрите состояние лонжеронов и рамки радиатора';
      case InspectionItemEnum.engine:
        return 'Осмотрите двигатель';
      case InspectionItemEnum.transmission:
        return 'Осмотрите трансмиссию';
      case InspectionItemEnum.frontInterior:
        return 'Осмотрите переднюю часть салона';
      case InspectionItemEnum.rearInterior:
        return 'Осмотрите заднюю часть салона';
      case InspectionItemEnum.computerDiagnostics:
        return 'Внесите результаты компьютерной диагностики';
      case InspectionItemEnum.completeness:
        return 'Укажите, что есть в комплекте авто';
      case InspectionItemEnum.externalLights:
        return 'Проверьте работоспособность световых приборов';
    }
  }

  String get imageName {
    switch (this) {
      case InspectionItemEnum.tires:
        return 'tires';
      case InspectionItemEnum.rims:
        return 'disks';
      case InspectionItemEnum.bodyFrame:
        return 'spars';
      case InspectionItemEnum.engine:
        return 'engine';
      case InspectionItemEnum.transmission:
        return 'transmission';
      case InspectionItemEnum.frontInterior:
        return 'front_salon';
      case InspectionItemEnum.rearInterior:
        return 'back_salon';
      case InspectionItemEnum.computerDiagnostics:
        return 'comp_diagnostics';
      case InspectionItemEnum.completeness:
        return 'completeness';
      case InspectionItemEnum.externalLights:
        return 'lights';
    }
  }

  bool get clearPrevRouteStack {
    switch (this) {
      case InspectionItemEnum.tires:
      case InspectionItemEnum.rims:
      case InspectionItemEnum.bodyFrame:
        return false;
      case InspectionItemEnum.engine:
        return true;
      case InspectionItemEnum.transmission:
      case InspectionItemEnum.frontInterior:
        return false;
      case InspectionItemEnum.rearInterior:
        return true;
      case InspectionItemEnum.computerDiagnostics:
      case InspectionItemEnum.completeness:
      case InspectionItemEnum.externalLights:
        return false;
    }
  }
}

InspectionItemEnum? getNextInspectionItem(InspectionItemEnum item) {
  const inspectionItems = InspectionItemEnum.values;
  final isParking = getIt.get<ScanCasesBloc>().scanCase?.isParking ?? false;
  final filteredItems = inspectionItems
      .where(
        (element) => isParking ? element.stageName != 'Комплектность' : true,
      )
      .toList();
  final nextItemIndex =
      filteredItems.indexWhere((element) => element == item) + 1;

  return filteredItems.length > nextItemIndex
      ? filteredItems[nextItemIndex]
      : null;
}

bool isEquipmentInspectionRoute(String? imageName) =>
    InspectionItemEnum.values.any((element) => element.imageName == imageName);

void navigateToInspectionPhase(BuildContext context, String imageName) {
  final inspectionItem = InspectionItemEnum.values
      .firstWhereOrNull((element) => element.imageName == imageName);

  switch (inspectionItem) {
    case InspectionItemEnum.tires:
      const WheelsInspectionFormRoute(InspectionItemEnum.tires).push(context);
      break;
    case InspectionItemEnum.rims:
      const WheelsInspectionFormRoute(InspectionItemEnum.rims).push(context);
    case null:
      break;
    default:
      MainInspectionFormRoute(inspectionItem).push(context);
      break;
  }
}
