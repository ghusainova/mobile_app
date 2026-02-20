import 'package:flutter/material.dart';

import '../../../../../../components/router/data/routes.dart';
import '../../../../../../components/styles/app_colors.dart';
import '../../../../../../components/widgets/buttons/blue_button.dart';
import '../../../../../../components/widgets/car_inspection_list_item.dart';
import '../../../../../../config/injectable/injectable.dart';
import '../../../../../master_sto/history/presentation/screens/history_content/rework_comment.dart';
import '../../../../credit_application/domain/credit_application/credit_application_bloc.dart';
import '../../../data/enums/credit_rework_types_enum.dart';
import '../../../data/models/credit_rework_model.dart';

class CreditReworkContent extends StatelessWidget {
  final CreditReworkModel creditReworkModel;
  const CreditReworkContent({super.key, required this.creditReworkModel});

  String? get commentOther => creditReworkModel.pages
      .firstWhere(
        (element) => element.type == CreditReworkItemType.other,
      )
      .comments
      .join('\n');

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          ReworkCommentWidget(
            comment: commentOther,
            margin: const EdgeInsets.only(bottom: 12),
          ),
          ...creditReworkModel.pages.map(
            (page) {
              if (page.type != CreditReworkItemType.other) {
                return CarInspectionItem(
                  title: page.type.title,
                  subtitleWidget: (page.comments.isNotEmpty)
                      ? Container(
                          padding: const EdgeInsets.only(top: 5),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Text(
                            page.comments.join('\n'),
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: AppColors.inactiveText),
                          ),
                        )
                      : null,
                  icon: page.type.iconPath,
                  onPressed: page.type.onRouteNav,
                );
              } else {
                return const SizedBox();
              }
            },
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: BlueButton(
                onPressed: () => _onSubmit(context),
                text: 'Отправить на проверку',
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onSubmit(BuildContext context) async {
    const CreditApplicationRoute().push(context);

    getIt
        .get<CreditApplicationBloc>()
        .add(const CreditApplicationEvent.sendRework());
  }
}
