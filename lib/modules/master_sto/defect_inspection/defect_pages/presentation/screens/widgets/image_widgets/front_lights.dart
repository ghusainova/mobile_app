import '../../../../../../shared/utilities/defect_imports.dart';

class FrontLightsImage extends StatelessWidget {
  const FrontLightsImage({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefectImage(
      children: [
        Image(
          alignment: Alignment.center,
          image: AssetImage(AppAssets.frontLights),
        ),
      ],
    );
  }
}
