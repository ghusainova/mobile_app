import '../../../../../../shared/utilities/defect_imports.dart';

class FrontBumperImage extends StatelessWidget {
  const FrontBumperImage({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefectImage(
      children: [
        Image(
          alignment: Alignment.center,
          height: 280,
          image: AssetImage(AppAssets.frontBumper),
        ),
      ],
    );
  }
}
