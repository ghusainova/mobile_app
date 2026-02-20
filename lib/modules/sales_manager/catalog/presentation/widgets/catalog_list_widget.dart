import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/_data/models/auto_info.dart';
import '../../domain/filter_bloc/filter_bloc.dart';
import '../../domain/order_list/catalog_bloc.dart';
import 'catalog_item_card_widget/catalog_item_card_widget.dart';

class CatalogListWidget extends StatefulWidget {
  final List<AutoInfo> catalogResponse;
  final bool updateOnScroll;

  const CatalogListWidget({
    required this.catalogResponse, super.key,
    this.updateOnScroll = true,
  });

  @override
  State<CatalogListWidget> createState() => _CatalogListWidgetState();
}

class _CatalogListWidgetState extends State<CatalogListWidget> {
  static const int pageLimit = 20;

  final scrollController = ScrollController();

  int offset = 0;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: NotificationListener<ScrollNotification>(
        onNotification: handleScrollNotification,
        child: Container(
          color: Colors.white,
          child: ListView.builder(
            shrinkWrap: true,
            controller: scrollController,
            itemCount: widget.catalogResponse.length,
            itemBuilder: (context, index) =>
                CatalogItemCard(autoInfo: widget.catalogResponse[index]),
          ),
        ),
      ),
    );
  }

  bool handleScrollNotification(ScrollNotification notification) {
    final catalogBloc = context.read<CatalogBloc>();

    if (widget.updateOnScroll &&
        notification is ScrollEndNotification &&
        scrollController.position.extentAfter == 0 &&
        !catalogBloc.isAppendLoading) {
      offset += pageLimit;
      catalogBloc.add(
        LoadCatalog(
          filter: context.read<FilterBloc>().currentFilter,
          offset: offset,
          prevContent: widget.catalogResponse,
        ),
      );
    }

    return false;
  }

  Future<void> onRefresh() async {
    offset = 0;
    context.read<FilterBloc>().add(const GetFilteredData());
  }
}
