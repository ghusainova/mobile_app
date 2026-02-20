import '../../../../../../shared/utilities/defect_imports.dart';

class RoofImage extends StatelessWidget {
  const RoofImage({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefectImage(
      children: [
        Image(
          alignment: Alignment.center,
          height: 280,
          image: AssetImage(AppAssets.roof),
        ),
        PointWidget(index: 1, topValue: 0.035, leftValue: 0.235),
        PointWidget(index: 2, topValue: 0.035, leftValue: 0.49),
        PointWidget(index: 3, topValue: 0.14, leftValue: 0.365),
        PointWidget(index: 4, topValue: 0.243, leftValue: 0.235),
        PointWidget(index: 5, topValue: 0.243, leftValue: 0.49),
      ],
    );
  }
}
