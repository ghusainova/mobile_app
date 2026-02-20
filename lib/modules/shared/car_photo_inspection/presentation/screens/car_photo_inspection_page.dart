import 'package:flutter/material.dart';

import '../../../../../components/router/data/routes.dart';
import '../../../../../components/styles/app_assets.dart';
import '../../../../../components/widgets/appbar/appbar_widget.dart';
import '../../../../../components/widgets/buttons/blue_button.dart';
import '../../../../../components/widgets/buttons/outlined_blue_button.dart';
import '../../../media_capture_vin/presentation/screens/widgets/buyer_media_form.dart';
import '../../data/constants/car_photo_inspection_route_args.dart';
import '../../data/models/car_photo_inspection_args.dart';
import '../../data/models/photo_inspection_info_item.dart';

class CarPhotoInspectionPage extends StatefulWidget {
  final CarPhotoInspectionArgs args;

  const CarPhotoInspectionPage(this.args, {super.key});

  @override
  State<CarPhotoInspectionPage> createState() => _CarPhotoInspectionPageState();
}

class _CarPhotoInspectionPageState extends State<CarPhotoInspectionPage> {
  final List<PhotoInspectionInfoItem> infoItems = [];

  @override
  void initState() {
    super.initState();
    infoItems.addAll(widget.args.inspectionInfoItems);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(widget.args.title),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.args.subtitle,
                style: Theme.of(context).textTheme.displayMedium,
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(vertical: 16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 32,
                  crossAxisSpacing: 8,
                ),
                itemCount: infoItems.length,
                itemBuilder: (context, index) => BuyerMediaForm(
                  caseId: widget.args.caseId,
                  documentType: infoItems[index].title,
                  infoItem: infoItems[index],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: OutlinedBlueButton(
                  text: 'Дополнительные фото',
                  showBorder: false,
                  leadingIcon: const Icon(Icons.add),
                  mainAxisAlignment: MainAxisAlignment.start,
                  onPressed: onAddAdditionalPhoto,
                ),
              ),
              BlueButton(text: widget.args.btnTitle, onPressed: onSubmit),
            ],
          ),
        ),
      ),
    );
  }

  void onAddAdditionalPhoto() {
    setState(() {
      infoItems.add(
        const PhotoInspectionInfoItem(
          iconPath: AppAssets.imagePlaceholderIcon,
          title: 'Дополнительные фото',
          isAdditional: true,
          forceOpenCamera: true,
        ),
      );
    });
  }

  void onSubmit() {
    if (widget.args.title == interiorInspectionArgs.title &&
        widget.args.onSubmit != null) {
      widget.args.onSubmit!();
    } else {
      final inArgs = interiorInspectionArgs.copyWith(
        caseId: widget.args.caseId,
        onSubmit: widget.args.onSubmit,
      );

      CarPhotoInspectionRoute(inArgs).push(context);
    }
  }
}
