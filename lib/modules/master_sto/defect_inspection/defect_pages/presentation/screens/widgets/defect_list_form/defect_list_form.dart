import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../config/injectable/injectable.dart';
import '../../../../../../../../components/widgets/card_widget/card_widget.dart';
import '../../../../../../../shared/media_capture_vin/data/models/media_file.dart';
import '../../../../../../../shared/media_capture_vin/presentation/screens/widgets/media_form.dart';
import '../../../../../../scan_cases/domain/scan_cases/scan_cases_bloc.dart';
import '../../../../../_shared/data/enum/car_body_part.dart';
import '../../../../../_shared/data/models/defect.dart';
import '../../../../domain/defects/defects_bloc.dart';
import 'defect_list_content.dart';

class DefectListFormWidget extends StatelessWidget {
  final CarBodyPart bodyPart;

  const DefectListFormWidget({required this.bodyPart, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DefectsBloc, DefectsState>(
      builder: (context, state) {
        final bloc = context.read<DefectsBloc>();
        final defectList = bloc.defect.defects ?? [];

        if (bloc.defect.isDefectListEmpty == true) {
          return const SizedBox();
        }

        return CardWidget(
          margin: const EdgeInsets.only(top: 16),
          contentPadding: EdgeInsets.zero,
          child: Column(
            children: [
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                separatorBuilder: (context, index) => const Divider(),
                itemCount: defectList.length,
                itemBuilder: (context, index) => DefectListContent(
                  defect: defectList[index],
                  onDelete: (defect) => _onDelete(context, defect),
                ),
              ),
              MediaForm(
                caseId: getIt.get<ScanCasesBloc>().scanCase?.caseId,
                documentType: bodyPart.label,
                cacheSize: const Size(70, 70),
                onLoaded: (mediaFiles) => onLoaded(context, mediaFiles),
              ),
            ],
          ),
        );
      },
    );
  }

  void onLoaded(BuildContext context, List<MediaFile> mediaFiles) {
    context.read<DefectsBloc>().mediaFiles = mediaFiles;
  }

  void _onDelete(BuildContext context, Defect updatedDefect) {
    final bloc = context.read<DefectsBloc>();
    final defects = bloc.defect.defects ?? [];
    final updatedDefects = defects
        .map((e) => e.title == updatedDefect.title ? updatedDefect : e)
        .toList();

    bloc.add(UpdateDefectStatus(updatedDefects));
  }
}
