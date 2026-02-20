import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../data/constants/old_car_ids.dart';
import '../../../../../../../../components/router/data/routes.dart';
import '../../../../../../../../components/styles/app_assets.dart';
import '../../../../../../../../components/styles/app_colors.dart';
import '../../../../../../../../components/widgets/snackbar/snackbar.dart';
import '../../../../../domain/auto_detail/auto_detail_bloc.dart';

class CarInspectionButton extends StatefulWidget {
  const CarInspectionButton({super.key});

  @override
  State<CarInspectionButton> createState() => _CarInspectionButtonState();
}

class _CarInspectionButtonState extends State<CarInspectionButton> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.paleBlue,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        onTap: navigateToInspection,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: SvgPicture.asset(AppAssets.carInspectionIcon),
        title: Text(
          'Акт осмотра авто',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        trailing: isLoading
            ? const SizedBox(
                width: 15,
                height: 15,
                child: CircularProgressIndicator(strokeWidth: 3),
              )
            : const Icon(
                Icons.chevron_right,
                color: Colors.grey,
              ),
      ),
    );
  }

  Future<void> navigateToInspection() async {
    if (isLoading) {
      return;
    }

    final autoDetailBloc = context.read<AutoDetailBloc>();
    final autoInfo = autoDetailBloc.autoInfo;

    if (autoInfo?.id != null && oldCarIds.contains(autoInfo!.id)) {
      setState(() => isLoading = true);
      final pdfUrl = await autoDetailBloc.getOldCarInspectionList(autoInfo.id);
      setState(() => isLoading = false);

      if (!mounted) {
        return;
      }

      if ((pdfUrl ?? '').isNotEmpty) {
        PdfViewRoute(pdfUrl!).push(context);
      } else {
        showSnackBar(context, 'Не удалось загрузить акт осмотра авто');
      }
    } else if (mounted) {
      CarInspectionRoute(autoInfo).push(context);
    }
  }
}
