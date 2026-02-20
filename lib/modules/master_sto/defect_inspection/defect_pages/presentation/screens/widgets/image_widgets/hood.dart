import '../../../../../../shared/utilities/defect_imports.dart';

class HoodImage extends StatelessWidget {
  const HoodImage({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefectImage(
      children: [
        Image(
          alignment: Alignment.center,
          image: AssetImage(AppAssets.hood),
        ),
        PointWidget(index: 1, topValue: 0.115, leftValue: 0.165),
        PointWidget(index: 2, topValue: 0.115, leftValue: 0.4),
        PointWidget(index: 3, topValue: 0.115, leftValue: 0.63),
        PointWidget(index: 4, topValue: 0.19, leftValue: 0.155),
        PointWidget(index: 5, topValue: 0.19, leftValue: 0.4),
        PointWidget(index: 6, topValue: 0.19, leftValue: 0.63),
        PointWidget(index: 7, topValue: 0.265, leftValue: 0.165),
        PointWidget(index: 8, topValue: 0.265, leftValue: 0.4),
        PointWidget(index: 9, topValue: 0.265, leftValue: 0.62),
      ],
    );
  }
}
