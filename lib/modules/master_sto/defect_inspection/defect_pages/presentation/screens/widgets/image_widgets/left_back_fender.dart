import '../../../../../../shared/utilities/defect_imports.dart';

class LeftBackFenderImage extends StatelessWidget {
  const LeftBackFenderImage({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefectImage(
      children: [
        Image(
          alignment: Alignment.center,
          fit: BoxFit.fitWidth,
          height: 343,
          image: AssetImage(AppAssets.leftBackFender),
        ),
        PointWidget(index: 1, topValue: 0.25, leftValue: 0.17),
        PointWidget(index: 2, topValue: 0.2, leftValue: 0.23),
        PointWidget(index: 3, topValue: 0.17, leftValue: 0.34),
        PointWidget(index: 4, topValue: 0.18, leftValue: 0.47),
        PointWidget(index: 5, topValue: 0.22, leftValue: 0.56),
        PointWidget(index: 6, topValue: 0.27, leftValue: 0.6),
        PointWidget(index: 7, topValue: 0.12, leftValue: 0.44),
        PointWidget(index: 8, topValue: 0.12, leftValue: 0.705),
        PointWidget(index: 9, topValue: 0.18, leftValue: 0.765),
        PointWidget(index: 10, topValue: 0.07, leftValue: 0.4),
        PointWidget(index: 11, topValue: 0.04, leftValue: 0.23),
      ],
    );
  }
}
