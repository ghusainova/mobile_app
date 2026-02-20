import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../components/styles/app_assets.dart';
import '../../../../../../components/styles/app_colors.dart';
import '../../../../../../components/widgets/car_inspection_list_item.dart';
import '../../../data/models/phase.dart';
import '../../../domain/history/history_bloc.dart';

class HistoryList extends StatelessWidget {
  final bool isFinalStage;

  final void Function(Phase? phase) onTap;

  const HistoryList({
    required this.onTap,
    required this.isFinalStage,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<HistoryBloc>();
    final history = bloc.history;
    const blurValue = 1.5;
    return Expanded(
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: history?.historyList.length ?? 0,
        itemBuilder: (context, i) {
          final phase = _getPhase(context, i);
          final imageName = _getImageAssetPath(phase?.imageName);

          final subtitle =
              history?.historyList[i].defectStatus == true && isFinalStage
                  ? 'Есть дефекты'
                  : null;
          final isAvailable =
              history?.historyList[i].availabilityStatus == true;

          return ImageFiltered(
            imageFilter: ImageFilter.blur(
              sigmaX: isAvailable ? 0 : blurValue,
              sigmaY: isAvailable ? 0 : blurValue,
            ),
            enabled: true,
            child: CarInspectionItem(
              icon: imageName,
              onPressed: () => isAvailable ? onTap(phase) : null,
              title: phase?.phaseName ?? '',
              subtitle: subtitle,
              subtitleColor: AppColors.red,
            ),
          );
        },
        separatorBuilder: (_, __) => const Divider(),
      ),
    );
  }

  Phase? _getPhase(BuildContext context, int index) {
    final history = context.read<HistoryBloc>().history;

    if ((history?.historyList ?? []).isNotEmpty) {
      return history?.historyList[index];
    }

    return null;
  }

  String _getImageAssetPath(String? imageName) {
    if (imageName != null) {
      return '${AppAssets.historyIconPath}$imageName.svg';
    }

    return AppAssets.carReportIcon;
  }
}
