import '../../../../../../shared/utilities/defect_imports.dart';

class TrunkImage extends StatelessWidget {
  const TrunkImage({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefectImage(
      children: [
        Image(
          alignment: Alignment.center,
          height: 342,
          image: AssetImage(AppAssets.trunkDefect),
        ),
        PointWidget(index: 1, topValue: 0.2, leftValue: 0.21),
        PointWidget(index: 2, topValue: 0.2, leftValue: 0.44),
        PointWidget(index: 3, topValue: 0.2, leftValue: 0.66),
        PointWidget(index: 4, topValue: 0.255, leftValue: 0.21),
        PointWidget(index: 5, topValue: 0.255, leftValue: 0.44),
        PointWidget(index: 6, topValue: 0.255, leftValue: 0.66),
        PointWidget(index: 7, topValue: 0.308, leftValue: 0.23),
        PointWidget(index: 8, topValue: 0.308, leftValue: 0.44),
        PointWidget(index: 9, topValue: 0.308, leftValue: 0.64),
      ],
    );
  }
}
