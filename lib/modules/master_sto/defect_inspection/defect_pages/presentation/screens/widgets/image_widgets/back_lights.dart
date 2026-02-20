import '../../../../../../shared/utilities/defect_imports.dart';

class BackLightsImage extends StatelessWidget {
  const BackLightsImage({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefectImage(
      children: [
        Image(
          alignment: Alignment.center,
          image: AssetImage(AppAssets.backLights),
        ),
      ],
    );
  }
}
