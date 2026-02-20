import '../../../../../../shared/utilities/defect_imports.dart';

class LeftFrontDoorImage extends StatelessWidget {
  const LeftFrontDoorImage({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefectImage(
      children: [
        Image(
          alignment: Alignment.center,
          fit: BoxFit.fitWidth,
          height: 343,
          image: AssetImage(AppAssets.leftFrontDoor),
        ),
        PointWidget(index: 1, topValue: 0.15, leftValue: 0.26),
        PointWidget(index: 2, topValue: 0.15, leftValue: 0.46),
        PointWidget(index: 3, topValue: 0.15, leftValue: 0.66),
        PointWidget(index: 4, topValue: 0.205, leftValue: 0.26),
        PointWidget(index: 5, topValue: 0.205, leftValue: 0.455),
        PointWidget(index: 6, topValue: 0.205, leftValue: 0.66),
        PointWidget(index: 7, topValue: 0.255, leftValue: 0.26),
        PointWidget(index: 8, topValue: 0.255, leftValue: 0.455),
        PointWidget(index: 9, topValue: 0.255, leftValue: 0.66),
        PointWidget(index: 10, topValue: 0.065, leftValue: 0.38),
        PointWidget(index: 11, topValue: 0.03, leftValue: 0.56),
      ],
    );
  }
}
