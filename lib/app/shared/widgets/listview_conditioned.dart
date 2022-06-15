import 'package:flutter/material.dart';

import 'circular_progress_widget.dart';

class ListViewConditioned extends StatelessWidget {
  final ScrollController? scrollController;
  final ScrollPhysics? physics;
  final bool shrinkWrap;

  final int? itemCount;
  final IndexedWidgetBuilder itemBuilder;

  final bool isLoading;

  final Widget? loadingWidget;
  final Widget? emptyWidget;

  const ListViewConditioned({
    Key? key,
    required this.itemBuilder,
    required this.itemCount,
    this.physics,
    this.isLoading = false,
    this.shrinkWrap = false,
    this.loadingWidget,
    this.emptyWidget,
    this.scrollController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return loadingWidget ?? const CircularProgressWidget();
    }

    if (itemCount == 0) {
      return Center(
        child: emptyWidget ?? const Text('Nenhum item encontrado'),
      );
    }

    return ListView.builder(
      physics: physics ?? const BouncingScrollPhysics(),
      shrinkWrap: shrinkWrap,
      controller: scrollController,
      itemCount: itemCount,
      itemBuilder: itemBuilder,
    );
  }
}
