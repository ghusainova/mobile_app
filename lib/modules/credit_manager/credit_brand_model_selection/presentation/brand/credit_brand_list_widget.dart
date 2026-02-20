import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/credit_brand/credit_brand_bloc.dart';

class CreditBrandListWidget extends StatefulWidget {
  final List<String> brands;
  final void Function(String selectedBrand) onSelect;

  const CreditBrandListWidget({
    super.key,
    required this.brands,
    required this.onSelect,
  });

  @override
  State<CreditBrandListWidget> createState() => _CreditBrandListWidgetState();
}

class _CreditBrandListWidgetState extends State<CreditBrandListWidget> {
  static const int pageLimit = 1;

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
            itemCount: widget.brands.length,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemBuilder: (context, index) => ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(widget.brands[index]),
              trailing: const Icon(Icons.keyboard_arrow_right),
              onTap: () => widget.onSelect(widget.brands[index]),
            ),
          ),
        ),
      ),
    );
  }

  bool handleScrollNotification(ScrollNotification notification) {
    final creditBrandBloc = context.read<CreditBrandBloc>();

    if (notification is ScrollEndNotification &&
        scrollController.position.extentAfter == 0 &&
        !creditBrandBloc.isAppendLoading) {
      offset += pageLimit;
      creditBrandBloc.add(
        CreditBrandEvent.load(
          offset: offset,
          prevContent: widget.brands,
        ),
      );
    }

    return false;
  }

  Future<void> onRefresh() async {
    offset = 0;
    CreditBrandEvent.load(
      offset: offset,
      prevContent: widget.brands,
    );
  }
}
