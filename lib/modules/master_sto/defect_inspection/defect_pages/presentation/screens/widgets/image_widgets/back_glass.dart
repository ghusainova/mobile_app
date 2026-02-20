import '../../../../../../shared/utilities/defect_imports.dart';

class BackGlassImage extends StatelessWidget {
  const BackGlassImage({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefectImage(
      children: [
        Image(
          alignment: Alignment.center,
          image: AssetImage(AppAssets.backGlass),
        ),
      ],
    );
  }
}
