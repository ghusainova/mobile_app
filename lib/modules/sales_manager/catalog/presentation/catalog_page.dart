import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/injectable/injectable.dart';
import '../../../../components/styles/app_colors.dart';
import '../../../../components/widgets/appbar/appbar_widget.dart';
import '../../../../components/widgets/snackbar/snackbar.dart';
import '../../client_processing/domain/qr/qr_bloc.dart';
import '../domain/filter_bloc/filter_bloc.dart';
import '../domain/order_list/catalog_bloc.dart';
import 'widgets/catalog_list_widget.dart';
import 'widgets/empty_search_widget.dart/empty_search_widget.dart';
import 'widgets/filter_widgets/catalog_filter_bar_widget.dart';

class CatalogPage extends StatelessWidget {
  const CatalogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backBase,
      appBar: const AppBarWidget('Каталог авто', showBackButton: false),
      body: MultiBlocProvider(
        providers: [
          _initCatalogBloc(),
          _initFilterBloc(),
          _initQrBloc(),
        ],
        child: Column(
          children: [
            const CatalogFilterBarWidget(),
            BlocConsumer<CatalogBloc, CatalogState>(
              listener: (context, state) {
                state.whenOrNull(
                  error: (message) => showSnackBar(context, message),
                );
              },
              builder: (context, state) {
                if (state is LoadingList) {
                  return const Expanded(
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else if (state is HasContent) {
                  return Expanded(
                    child: CatalogListWidget(
                      catalogResponse: state.catalogResponse,
                    ),
                  );
                }

                return const EmptyCatalogWidget();
              },
            ),
          ],
        ),
      ),
    );
  }

  BlocProvider<CatalogBloc> _initCatalogBloc() {
    return BlocProvider.value(
      value: getIt.get<CatalogBloc>()..add(const LoadCatalog()),
    );
  }

  BlocProvider<FilterBloc> _initFilterBloc() {
    return BlocProvider.value(value: getIt.get<FilterBloc>());
  }

  BlocProvider<QrBloc> _initQrBloc() {
    return BlocProvider.value(value: getIt.get<QrBloc>());
  }
}
