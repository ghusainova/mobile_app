import 'package:flutter/material.dart';

import '../../../../../config/injectable/injectable.dart';
import '../../../../../components/router/data/routes.dart';
import '../../../../../components/widgets/buttons/blue_button.dart';
import '../../../../../components/widgets/page_form_widget.dart';
import '../../../../../components/widgets/snackbar/snackbar.dart';
import '../../../../../components/widgets/text_field_read_only.dart';
import '../../../../../components/widgets/text_field_widget.dart';
import '../../../../shared/_data/constants/global_constants.dart';
import '../../../../shared/brand_model_selection/data/model/brand_model_response.dart';
import '../../../../shared/brand_model_selection/presentation/brand_model_selection.dart';
import '../../../../shared/car_photo_inspection/data/constants/car_photo_inspection_route_args.dart';
import '../../../queue/domain/buyout/buyout_bloc.dart';
import '../../../search_case/data/model/updating_info_params.dart';
import '../../../shared/_data/repositories/buyout_shared_repository.dart';

class EditCarDataPage extends StatefulWidget {
  const EditCarDataPage({super.key});

  @override
  State<EditCarDataPage> createState() => _EditCarDataPageState();
}

class _EditCarDataPageState extends State<EditCarDataPage> {
  final bloc = getIt.get<BuyoutBloc>();
  late BrandModelResponse brandModel;
  String year = '';

  @override
  void initState() {
    super.initState();
    mapFields();
  }

  void mapFields() {
    final autoInfo = bloc.autoInfo;
    brandModel = BrandModelResponse(
      brand: autoInfo?.auto?.brand ?? '',
      model: autoInfo?.auto?.model ?? '',
    );
    year = autoInfo?.auto?.year.toString() ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return PageFormWidget(
      appBarTitle: 'Данные c объявления',
      pageTitle: 'Подойдите к авто и сверьте данные c объявления',
      children: [
        TextFieldReadOnly(
          initialText: '${brandModel.brand} ${brandModel.model}',
          labelText: Constants.brandModel,
          onTap: () => selectCarBrandModel(context),
        ),
        TextFieldWidget(
          initialText: year,
          margin: const EdgeInsets.only(top: 16, bottom: 8),
          labelText: 'Год выпуска в объявлении',
          digitsOnly: true,
          keyboardType: TextInputType.number,
          onTextChanged: (text) => setState(() => year = text),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: BlueButton(
              text: 'Продолжить',
              onPressed: _saveAndRoute,
            ),
          ),
        ),
      ],
    );
  }

  void selectCarBrandModel(BuildContext context) async {
    final response = await selectBrandModel(context);

    if (context.mounted && response.isSingleResponseNotEmpty) {
      setState(
        () => brandModel = brandModel.copyWith(
          brand: response.brand,
          model: response.model,
        ),
      );
    }
  }

  void _saveAndRoute() async {
    final updatingInfoParams = UpdatingInfoParams(
      brand: brandModel.brand,
      model: brandModel.model,
      year: year,
    );

    bool infoIsUpdated = await getIt
        .get<BuyoutSharedRepository>()
        .updateAutoInfo(bloc.autoInfo?.id, updatingInfoParams);
    if (!mounted) {
      return;
    }
    if (infoIsUpdated) {
      showSnackBar(context, 'Информация обновлена');
      final exArgs = exteriorInspectionArgs;
      CarPhotoInspectionRoute(exArgs).push(context);
    } else {
      showSnackBar(context, 'Не удалось обновить информацию');
    }
  }
}
