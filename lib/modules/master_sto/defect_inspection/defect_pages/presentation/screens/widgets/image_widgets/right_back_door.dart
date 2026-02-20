import '../../../../../../shared/utilities/defect_imports.dart';

class RightBackDoorImage extends StatelessWidget {
  const RightBackDoorImage({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefectImage(
      children: [
        Image(
          alignment: Alignment.center,
          fit: BoxFit.fitWidth,
          height: 343,
          image: AssetImage(AppAssets.rightBackDoor),
        ),
        PointWidget(index: 1, topValue: 0.137, leftValue: 0.24),
        PointWidget(index: 2, topValue: 0.138, leftValue: 0.41),
        PointWidget(index: 3, topValue: 0.138, leftValue: 0.57),
        PointWidget(index: 4, topValue: 0.191, leftValue: 0.294),
        PointWidget(index: 5, topValue: 0.192, leftValue: 0.44),
        PointWidget(index: 6, topValue: 0.192, leftValue: 0.585),
        PointWidget(index: 7, topValue: 0.245, leftValue: 0.36),
        PointWidget(index: 8, topValue: 0.245, leftValue: 0.48),
        PointWidget(index: 9, topValue: 0.245, leftValue: 0.6),
      ],
    );
  }
}
