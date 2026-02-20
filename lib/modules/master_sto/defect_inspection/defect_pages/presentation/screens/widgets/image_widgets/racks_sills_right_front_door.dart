import '../../../../../../shared/utilities/defect_imports.dart';

class RacksSillsRightFrontDoorImage extends StatelessWidget {
  const RacksSillsRightFrontDoorImage({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefectImage(
      children: [
        Image(
          alignment: Alignment.center,
          fit: BoxFit.fitWidth,
          height: 342,
          image: AssetImage(AppAssets.racksSillsRightFrontDoor),
        ),
        PointWidget(index: 1, topValue: 0.115, leftValue: 0.145),
        PointWidget(index: 2, topValue: 0.048, leftValue: 0.12),
        PointWidget(index: 3, topValue: 0.03, leftValue: 0.308),
        PointWidget(index: 4, topValue: 0.08, leftValue: 0.56),
        PointWidget(index: 5, topValue: 0.27, leftValue: 0.26),
        PointWidget(index: 6, topValue: 0.27, leftValue: 0.516),
        PointWidget(index: 7, topValue: 0.186, leftValue: 0.17),
        PointWidget(index: 8, topValue: 0.186, leftValue: 0.66),
      ],
    );
  }
}
