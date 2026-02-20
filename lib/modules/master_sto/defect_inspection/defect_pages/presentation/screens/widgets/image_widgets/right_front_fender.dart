import '../../../../../../shared/utilities/defect_imports.dart';

class RightFrontFenderImage extends StatelessWidget {
  const RightFrontFenderImage({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefectImage(
      children: [
        Image(
          alignment: Alignment.center,
          fit: BoxFit.fitWidth,
          height: 343,
          image: AssetImage(AppAssets.rightFrontFender),
        ),
        PointWidget(index: 1, topValue: 0.125, leftValue: 0.24),
        PointWidget(index: 2, topValue: 0.135, leftValue: 0.46),
        PointWidget(index: 3, topValue: 0.145, leftValue: 0.68),
        PointWidget(index: 4, topValue: 0.24, leftValue: 0.22),
        PointWidget(index: 5, topValue: 0.178, leftValue: 0.285),
        PointWidget(index: 6, topValue: 0.21, leftValue: 0.66),
      ],
    );
  }
}
