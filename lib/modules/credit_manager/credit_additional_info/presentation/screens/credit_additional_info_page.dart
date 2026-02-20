import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../components/widgets/no_content_widget.dart';
import '../../../../../components/widgets/page_form_widget.dart';
import '../../../../../components/widgets/snackbar/snackbar.dart';
import '../../../../../config/injectable/injectable.dart';
import '../../../../shared/additional_info/data/enums/additional_info_param_enum.dart';
import '../../../shared/_data/helpers/credit_route_args.dart';
import '../../domain/credit_additional_info/credit_additional_info_bloc.dart';
import 'widgets/credit_additional_info_content.dart';

class CreditAdditionalInfoPage extends StatefulWidget {
  const CreditAdditionalInfoPage({super.key});

  @override
  State<CreditAdditionalInfoPage> createState() =>
      _CreditAdditionalInfoPageState();
}

class _CreditAdditionalInfoPageState extends State<CreditAdditionalInfoPage> {
  @override
  void initState() {
    super.initState();
    load();
  }

  @override
  Widget build(BuildContext context) {
    return PageFormWidget(
      appBarTitle: 'Дополнительная информация',
      useOnlyTitlePadding: true,
      child: BlocProvider.value(
        value: getIt.get<CreditAdditionalInfoBloc>(),
        child:
            BlocConsumer<CreditAdditionalInfoBloc, CreditAdditionalInfoState>(
          listener: (context, state) {
            state.whenOrNull(
              saved: navigateCreditVinVideo,
              error: (message) => showSnackBar(context, message),
            );
          },
          builder: (context, state) {
            return state.whenOrNull(
                  error: (message) => NoContentWidget(
                    onRefresh: load,
                    errorMessage: message,
                  ),
                  loaded: (additionalInfo) => RefreshIndicator(
                    onRefresh: load,
                    child: CreditAdditionalInfoContent(
                      additionalInfo: additionalInfo,
                      onSave: save,
                      onChangeInfo: onChangeInfo,
                      isLoading: state is Loading,
                    ),
                  ),
                ) ??
                const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  Future<void> load() async {
    getIt
        .get<CreditAdditionalInfoBloc>()
        .add(const CreditAdditionalInfoEvent.load());
  }

  void save() {
    getIt
        .get<CreditAdditionalInfoBloc>()
        .add(const CreditAdditionalInfoEvent.save());
  }

  void onChangeInfo(AdditionalInfoParamEnum param, String value) {
    getIt.get<CreditAdditionalInfoBloc>().add(
          CreditAdditionalInfoEvent.changeAdditionalInfo(
            param: param,
            value: value,
          ),
        );
  }
}
