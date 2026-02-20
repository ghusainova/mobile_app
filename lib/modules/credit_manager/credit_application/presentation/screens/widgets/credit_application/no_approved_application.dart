import '../../../../../../../components/widgets/buttons/blue_button.dart';
import '../../../../../../../components/widgets/card_widget/card_widget.dart';
import '../../../../../../../config/injectable/injectable.dart';
import '../../../../../../master_sto/shared/utilities/defect_imports.dart';
import '../../../../domain/credit_application/credit_application_bloc.dart';

class NoApprovedApplication extends StatelessWidget {
  final String? title;

  const NoApprovedApplication({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      margin: const EdgeInsets.only(bottom: 16),
      title: title,
      child: BlueButton(
        text: 'Обновить',
        onPressed: () => getIt.get<CreditApplicationBloc>().add(
              const CreditApplicationEvent.getCreditApplicationOrder(
                getStatusList: true,
              ),
            ),
      ),
    );
  }
}
