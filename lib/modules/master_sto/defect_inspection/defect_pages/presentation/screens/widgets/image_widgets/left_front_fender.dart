import '../../../../../../shared/utilities/defect_imports.dart';

class LeftFrontFenderImage extends StatelessWidget {
  const LeftFrontFenderImage({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefectImage(
      children: [
        Image(
          alignment: Alignment.center,
          fit: BoxFit.fitWidth,
          height: 343,
          image: AssetImage(AppAssets.leftFrontFender),
        ),
        PointWidget(index: 1, topValue: 0.145, leftValue: 0.2),
        PointWidget(index: 2, topValue: 0.135, leftValue: 0.42),
        PointWidget(index: 3, topValue: 0.125, leftValue: 0.62),
        PointWidget(index: 4, topValue: 0.21, leftValue: 0.21),
        PointWidget(index: 5, topValue: 0.175, leftValue: 0.58),
        PointWidget(index: 6, topValue: 0.24, leftValue: 0.66),
      ],
    );
  }
}
