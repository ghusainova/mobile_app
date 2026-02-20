import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../shared/_data/constants/global_constants.dart';
import '../../../../../../components/widgets/buttons/blue_button.dart';
import '../../../../../../components/widgets/text_field_read_only.dart';
import '../../../../../shared/brand_model_selection/presentation/brand_model_selection.dart';
import '../../../data/enum/main_info_param_enum.dart';
import '../../../data/models/main_info.dart';
import '../../../domain/main_info/main_info_bloc.dart';
import 'mileage_modal.dart';
import 'text_field_content_list_widget.dart';

class MainInfoContent extends StatefulWidget {
  final MainInfo mainInfo;

  const MainInfoContent({
    required this.mainInfo,
    super.key,
  });

  @override
  State<MainInfoContent> createState() => _MainInfoContentState();
}

class _MainInfoContentState extends State<MainInfoContent> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      children: [
        Text(
          'Заполните основную информацию об авто',
          style: Theme.of(context).textTheme.displayMedium,
        ),
        TextFieldReadOnly(
          initialText: '${widget.mainInfo.brand} ${widget.mainInfo.model}',
          labelText: Constants.brandModel,
          margin: const EdgeInsets.only(top: 24, bottom: 16),
          onTap: selectCarBrandModel,
        ),
        TextFieldContentListWidget(
          mainInfo: widget.mainInfo,
          onChanged: changeInfo,
        ),
        TextFieldReadOnly(
          initialText: widget.mainInfo.mileage,
          labelText: MainInfoParamEnum.mileage.label,
          onTap: selectMileage,
        ),
        BlueButton(
          isLoading: context.read<MainInfoBloc>().state is Loading,
          onPressed: () => context
              .read<MainInfoBloc>()
              .add(const MainInfoEvent.save(setStage: true)),
        ),
      ],
    );
  }

  void changeInfo(MainInfoParamEnum param, String value) {
    context
        .read<MainInfoBloc>()
        .add(MainInfoEvent.changeMainInfo(key: param, value: value));
  }

  void selectCarBrandModel() async {
    final response = await selectBrandModel(context);

    if (context.mounted && response.isSingleResponseNotEmpty) {
      changeInfo(MainInfoParamEnum.brand, response.brand);
      changeInfo(MainInfoParamEnum.model, response.model);
    }
  }

  void selectMileage() async {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
      context: context,
      isScrollControlled: true,
      builder: (_) => MileageModal(
        mainInfo: widget.mainInfo,
        onSubmit: (mileage) => changeInfo(MainInfoParamEnum.mileage, mileage),
      ),
    );
  }
}
