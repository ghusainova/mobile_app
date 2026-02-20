import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../config/injectable/injectable.dart';
import '../../../data/enum/filter_sort_enum.dart';
import '../../../../../../components/styles/app_assets.dart';
import '../../../../../../components/widgets/buttons/outlined_blue_button.dart';
import '../../../domain/filter_bloc/filter_bloc.dart';
import 'modals/sort.dart';

class SortingWidget extends StatelessWidget {
  const SortingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt.get<FilterBloc>(),
      child: BlocBuilder<FilterBloc, FilterState>(
        builder: (context, state) {
          return OutlinedBlueButton(
            text: context.read<FilterBloc>().currentFilter.sortBy.label,
            leadingIcon: SvgPicture.asset(AppAssets.sortIcon),
            showBorder: false,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            mainAxisAlignment: MainAxisAlignment.start,
            onPressed: () => _openModal(context),
          );
        },
      ),
    );
  }

  void _openModal(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
      context: context,
      isScrollControlled: true,
      builder: (context) => const Sort(),
    );
  }
}
