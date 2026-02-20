import '../../../../../../shared/utilities/defect_imports.dart';

class BackBumperImage extends StatelessWidget {
  const BackBumperImage({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefectImage(
      children: [
        Image(
          alignment: Alignment.center,
          image: AssetImage(AppAssets.backBumper),
        ),
      ],
    );
  }
}
