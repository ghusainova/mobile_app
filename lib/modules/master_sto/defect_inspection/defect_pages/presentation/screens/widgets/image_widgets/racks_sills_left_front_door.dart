import '../../../../../../shared/utilities/defect_imports.dart';

class RacksSillsLeftFrontDoorImage extends StatelessWidget {
  const RacksSillsLeftFrontDoorImage({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefectImage(
      children: [
        Image(
          alignment: Alignment.center,
          fit: BoxFit.fitWidth,
          height: 342,
          image: AssetImage(AppAssets.racksSillsLeftFrontDoor),
        ),
        PointWidget(index: 1, topValue: 0.08, leftValue: 0.31),
        PointWidget(index: 2, topValue: 0.03, leftValue: 0.568),
        PointWidget(index: 3, topValue: 0.048, leftValue: 0.76),
        PointWidget(index: 4, topValue: 0.115, leftValue: 0.732),
        PointWidget(index: 5, topValue: 0.27, leftValue: 0.36),
        PointWidget(index: 6, topValue: 0.27, leftValue: 0.615),
        PointWidget(index: 7, topValue: 0.19, leftValue: 0.22),
        PointWidget(index: 8, topValue: 0.19, leftValue: 0.7),
      ],
    );
  }
}
