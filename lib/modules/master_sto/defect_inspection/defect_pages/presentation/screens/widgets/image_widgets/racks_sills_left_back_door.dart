import '../../../../../../shared/utilities/defect_imports.dart';

class RacksSillsLeftBackDoorImage extends StatelessWidget {
  const RacksSillsLeftBackDoorImage({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefectImage(
      children: [
        Image(
          alignment: Alignment.center,
          fit: BoxFit.fitWidth,
          height: 342,
          image: AssetImage(AppAssets.racksSillsLeftBackDoor),
        ),
        PointWidget(index: 1, topValue: 0.04, leftValue: 0.63),
        PointWidget(index: 2, topValue: 0.095, leftValue: 0.685),
        PointWidget(index: 3, topValue: 0.262, leftValue: 0.37),
        PointWidget(index: 4, topValue: 0.262, leftValue: 0.54),
        PointWidget(index: 6, topValue: 0.184, leftValue: 0.65),
      ],
    );
  }
}
