import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../components/UI/client_info_widgets/client_initials/client_initials_widget.dart';
import '../../../../../../../components/widgets/buttons/blue_button.dart';
import '../../../../../../../components/widgets/table_content_item.dart';
import '../../../../../../../config/injectable/injectable.dart';
import '../../../../../../shared/_data/constants/global_constants.dart';
import '../../../../../../shared/_domain/utility/formatters/num_formatter.dart';
import '../../../../../../shared/queue/data/models/active_client_dto.dart';
import '../../../../../credit_application/data/models/credit_application.dart';
import '../../../../domain/bloc/seller_data_bloc.dart';

class SellerCarInfoWidget extends StatelessWidget {
  final CreditApplication creditApplication;
  const SellerCarInfoWidget({super.key, required this.creditApplication});

  ActiveClientDTO? get _activeClient =>
      mapSellerToActiveClient(creditApplication.seller);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 18),
                child: Text(
                  'Подтвердите данные продавца и авто',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
              if (_activeClient != null)
                ClientInitialsWidget(_activeClient!, showPhoneNumber: false),
              ...infoList(),
            ],
          ),
        ),
        BlocBuilder<SellerDataBloc, SellerDataState>(
          builder: (context, state) => BlueButton(
            isLoading: state is Loading,
            onPressed: () => _onSubmit(context),
          ),
        ),
      ],
    );
  }

  List<Widget> infoList() {
    return [
      TableContentItem(
        title: 'ИИН продавца',
        value: creditApplication.seller.iin,
      ),
      TableContentItem(
        title: Constants.brand,
        value: creditApplication.auto.brand,
      ),
      TableContentItem(
        title: Constants.model,
        value: creditApplication.auto.model,
      ),
      TableContentItem(
        title: Constants.year,
        value: creditApplication.auto.year.toString(),
      ),
      TableContentItem(
        title: 'Стоимость',
        value: formatNum(
          creditApplication.auto.price.toInt().toString(),
          addCurrencySign: true,
        ),
      ),
      TableContentItem(
        title: Constants.stateNumber,
        value: creditApplication.auto.stateNumber,
      ),
      TableContentItem(
        title: Constants.vin,
        value: creditApplication.auto.vin,
        caseFormat: false,
      ),
    ];
  }

  void _onSubmit(BuildContext context) {
    getIt.get<SellerDataBloc>().add(const ConfirmData());
  }
}
