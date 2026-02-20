import '../../../../../../shared/utilities/defect_imports.dart';

class RightBackFenderImage extends StatelessWidget {
  const RightBackFenderImage({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefectImage(
      children: [
        Image(
          alignment: Alignment.center,
          fit: BoxFit.fitWidth,
          height: 343,
          image: AssetImage(AppAssets.rightBackFender),
        ),
        PointWidget(index: 1, topValue: 0.27, leftValue: 0.285),
        PointWidget(index: 2, topValue: 0.22, leftValue: 0.32),
        PointWidget(index: 3, topValue: 0.178, leftValue: 0.405),
        PointWidget(index: 4, topValue: 0.168, leftValue: 0.54),
        PointWidget(index: 5, topValue: 0.198, leftValue: 0.65),
        PointWidget(index: 6, topValue: 0.248, leftValue: 0.71),
        PointWidget(index: 7, topValue: 0.18, leftValue: 0.11),
        PointWidget(index: 8, topValue: 0.115, leftValue: 0.17),
        PointWidget(index: 9, topValue: 0.115, leftValue: 0.435),
        PointWidget(index: 10, topValue: 0.07, leftValue: 0.47),
        PointWidget(index: 11, topValue: 0.04, leftValue: 0.65),
      ],
    );
  }
}
