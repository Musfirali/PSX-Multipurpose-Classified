import 'package:flutter/material.dart';

import '../../../../../../vendor_ui/item/list_with_filter/components/item/widgets/filter_item_list.dart';

class CustomItemListView extends StatefulWidget {
  const CustomItemListView(
      {Key? key, required this.animationController,  this.isGrid})
      : super(key: key);

  final AnimationController animationController;
  final bool? isGrid;

  @override
  State<CustomItemListView> createState() => _CustomItemListViewState();
}

class _CustomItemListViewState extends State<CustomItemListView> {
  @override
  Widget build(BuildContext context) {
    return ItemListView(
        animationController: widget.animationController, isGrid: widget.isGrid!);
  }
}
