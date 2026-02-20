import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../components/UI/search_bar_widget.dart';
import '../../../domain/filter_bloc/filter_bloc.dart';
import 'horizontal_filter_widget/horizontal_filter_widget.dart';
import 'sorting_widget.dart';

class CatalogFilterBarWidget extends StatelessWidget {
  const CatalogFilterBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          BlocBuilder<FilterBloc, FilterState>(
            builder: (context, state) {
              final filterBloc = context.read<FilterBloc>();
              final filter = filterBloc.currentFilter;

              return SearchBarWidget(
                initialText: filter.searchValue ?? '',
                onSearch: (text) => _onSearch(context, text),
              );
            },
          ),
          const HorizontalFilterWidget(),
          const SortingWidget(),
        ],
      ),
    );
  }

  void _onSearch(BuildContext context, String text) {
    context.read<FilterBloc>().add(SearchByText(text));
  }
}
