import '../../../../../../shared/utilities/defect_imports.dart';

class RightFrontDoorImage extends StatelessWidget {
  const RightFrontDoorImage({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefectImage(
      children: [
        Image(
          alignment: Alignment.center,
          fit: BoxFit.fitWidth,
          height: 343,
          image: AssetImage(AppAssets.rightFrontDoor),
        ),
        PointWidget(index: 1, topValue: 0.15, leftValue: 0.22),
        PointWidget(index: 2, topValue: 0.15, leftValue: 0.42),
        PointWidget(index: 3, topValue: 0.15, leftValue: 0.62),
        PointWidget(index: 4, topValue: 0.205, leftValue: 0.22),
        PointWidget(index: 5, topValue: 0.205, leftValue: 0.42),
        PointWidget(index: 6, topValue: 0.205, leftValue: 0.62),
        PointWidget(index: 7, topValue: 0.255, leftValue: 0.22),
        PointWidget(index: 8, topValue: 0.255, leftValue: 0.42),
        PointWidget(index: 9, topValue: 0.255, leftValue: 0.62),
        PointWidget(index: 10, topValue: 0.06, leftValue: 0.48),
        PointWidget(index: 11, topValue: 0.03, leftValue: 0.3),
      ],
    );
  }
}
