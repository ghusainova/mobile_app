// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../../../defect_pages/presentation/screens/widgets/image_widgets/back_bumper.dart';
import '../../../defect_pages/presentation/screens/widgets/image_widgets/back_glass.dart';
import '../../../defect_pages/presentation/screens/widgets/image_widgets/back_lights.dart';
import '../../../defect_pages/presentation/screens/widgets/image_widgets/front_bumper.dart';
import '../../../defect_pages/presentation/screens/widgets/image_widgets/front_lights.dart';
import '../../../defect_pages/presentation/screens/widgets/image_widgets/hood.dart';
import '../../../defect_pages/presentation/screens/widgets/image_widgets/left_back_door.dart';
import '../../../defect_pages/presentation/screens/widgets/image_widgets/left_back_fender.dart';
import '../../../defect_pages/presentation/screens/widgets/image_widgets/left_front_door.dart';
import '../../../defect_pages/presentation/screens/widgets/image_widgets/left_front_fender.dart';
import '../../../defect_pages/presentation/screens/widgets/image_widgets/racks_sills_left_back_door.dart';
import '../../../defect_pages/presentation/screens/widgets/image_widgets/racks_sills_left_front_door.dart';
import '../../../defect_pages/presentation/screens/widgets/image_widgets/racks_sills_right_back_door.dart';
import '../../../defect_pages/presentation/screens/widgets/image_widgets/racks_sills_right_front_door.dart';
import '../../../defect_pages/presentation/screens/widgets/image_widgets/right_back_door.dart';
import '../../../defect_pages/presentation/screens/widgets/image_widgets/right_back_fender.dart';
import '../../../defect_pages/presentation/screens/widgets/image_widgets/right_front_door.dart';
import '../../../defect_pages/presentation/screens/widgets/image_widgets/right_front_fender.dart';
import '../../../defect_pages/presentation/screens/widgets/image_widgets/roof.dart';
import '../../../defect_pages/presentation/screens/widgets/image_widgets/trunk.dart';
import '../../../defect_pages/presentation/screens/widgets/image_widgets/windshield.dart';

enum CarBodyPart {
  roof,
  hood,
  windshield,
  frontBumper,
  frontLights,
  leftFrontFender,
  leftFrontDoor,
  racksSillsLeftFrontDoor,
  leftBackDoor,
  racksSillsLeftBackDoor,
  leftBackFender,
  backGlass,
  trunk,
  backBumper,
  backLights,
  rightBackFender,
  rightBackDoor,
  racksSillsRightBackDoor,
  rightFrontDoor,
  racksSillsRightFrontDoor,
  rightFrontFender,
  defectConfirmation
}

extension CarBodyPartExt on CarBodyPart {
  String get label {
    switch (this) {
      case CarBodyPart.roof:
        return 'Крыша';
      case CarBodyPart.hood:
        return 'Капот';
      case CarBodyPart.windshield:
        return 'Лобовое стекло';
      case CarBodyPart.frontBumper:
        return 'Передний бампер';
      case CarBodyPart.frontLights:
        return 'Передние световые приборы';
      case CarBodyPart.leftFrontFender:
        return 'Левое переднее крыло';
      case CarBodyPart.leftFrontDoor:
        return 'Левая передняя дверь';
      case CarBodyPart.racksSillsLeftFrontDoor:
        return 'Стойки и порожки левой передней двери';
      case CarBodyPart.leftBackDoor:
        return 'Левая задняя дверь';
      case CarBodyPart.racksSillsLeftBackDoor:
        return 'Стойки и порожки левой задней двери';
      case CarBodyPart.leftBackFender:
        return 'Левое заднее крыло';
      case CarBodyPart.backGlass:
        return 'Заднее стекло';
      case CarBodyPart.trunk:
        return 'Багажник';
      case CarBodyPart.backBumper:
        return 'Задний бампер';
      case CarBodyPart.backLights:
        return 'Задние световые приборы';
      case CarBodyPart.rightBackFender:
        return 'Правое заднее крыло';
      case CarBodyPart.rightBackDoor:
        return 'Правая задняя дверь';
      case CarBodyPart.racksSillsRightBackDoor:
        return 'Стойки и порожки правой задней двери';
      case CarBodyPart.rightFrontDoor:
        return 'Правая передняя дверь';
      case CarBodyPart.racksSillsRightFrontDoor:
        return 'Стойки и порожки правой передней двери';
      case CarBodyPart.rightFrontFender:
        return 'Правое переднее крыло';
      case CarBodyPart.defectConfirmation:
        return 'Подтверждение осмотра';
    }
  }

  String get genitiveLabel {
    switch (this) {
      case CarBodyPart.roof:
        return 'крышу';
      case CarBodyPart.leftFrontDoor:
        return 'левую переднюю дверь';
      case CarBodyPart.leftBackDoor:
        return 'левую заднюю дверь';
      case CarBodyPart.rightFrontDoor:
        return 'правую переднюю дверь';
      case CarBodyPart.rightBackDoor:
        return 'правую заднюю дверь';
      default:
        return label.toLowerCase();
    }
  }

  bool get recolourIsNeed {
    switch (this) {
      case CarBodyPart.roof:
        return true;
      case CarBodyPart.hood:
        return true;
      case CarBodyPart.trunk:
        return true;

      case CarBodyPart.leftFrontFender:
        return true;
      case CarBodyPart.leftBackFender:
        return true;
      case CarBodyPart.rightBackFender:
        return true;
      case CarBodyPart.rightFrontFender:
        return true;

      case CarBodyPart.leftFrontDoor:
        return true;
      case CarBodyPart.leftBackDoor:
        return true;
      case CarBodyPart.rightBackDoor:
        return true;
      case CarBodyPart.rightFrontDoor:
        return true;

      case CarBodyPart.racksSillsLeftFrontDoor:
        return true;
      case CarBodyPart.racksSillsLeftBackDoor:
        return true;
      case CarBodyPart.racksSillsRightBackDoor:
        return true;
      case CarBodyPart.racksSillsRightFrontDoor:
        return true;

      default:
        return false;
    }
  }

  Widget get imageWidget {
    switch (this) {
      case CarBodyPart.roof:
        return RoofImage();
      case CarBodyPart.hood:
        return HoodImage();
      case CarBodyPart.backGlass:
        return BackGlassImage();
      case CarBodyPart.windshield:
        return WindshieldImage();

      case CarBodyPart.trunk:
        return TrunkImage();
      case CarBodyPart.backBumper:
        return BackBumperImage();
      case CarBodyPart.frontBumper:
        return FrontBumperImage();

      case CarBodyPart.backLights:
        return BackLightsImage();
      case CarBodyPart.frontLights:
        return FrontLightsImage();

      case CarBodyPart.leftBackDoor:
        return LeftBackDoorImage();
      case CarBodyPart.leftFrontDoor:
        return LeftFrontDoorImage();
      case CarBodyPart.rightBackDoor:
        return RightBackDoorImage();
      case CarBodyPart.rightFrontDoor:
        return RightFrontDoorImage();

      case CarBodyPart.leftBackFender:
        return LeftBackFenderImage();
      case CarBodyPart.leftFrontFender:
        return LeftFrontFenderImage();
      case CarBodyPart.rightBackFender:
        return RightBackFenderImage();
      case CarBodyPart.rightFrontFender:
        return RightFrontFenderImage();

      case CarBodyPart.racksSillsLeftBackDoor:
        return RacksSillsLeftBackDoorImage();
      case CarBodyPart.racksSillsLeftFrontDoor:
        return RacksSillsLeftFrontDoorImage();
      case CarBodyPart.racksSillsRightBackDoor:
        return RacksSillsRightBackDoorImage();
      case CarBodyPart.racksSillsRightFrontDoor:
        return RacksSillsRightFrontDoorImage();

      default:
        return const SizedBox();
    }
  }
}

CarBodyPart getBodyPartFromLabel(String label) {
  return CarBodyPart.values.firstWhere((bodyPart) => bodyPart.label == label);
}

CarBodyPart? getNextBodyPart(CarBodyPart item) {
  const carBodyParts = CarBodyPart.values;
  final nextItemIndex =
      carBodyParts.indexWhere((element) => element == item) + 1;
  return carBodyParts.length > nextItemIndex
      ? carBodyParts[nextItemIndex]
      : null;
}
