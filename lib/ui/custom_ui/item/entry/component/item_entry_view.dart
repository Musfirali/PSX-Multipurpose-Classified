import 'package:flutter/material.dart';

import '../../../../../core/vendor/viewobject/product.dart';
import '../../../../vendor_ui/item/entry/component/item_entry_view.dart';

class CustomItemEntryView extends StatefulWidget {
  const CustomItemEntryView({
    Key? key,
    required this.flag,
    required this.item,
    required this.categoryId,
    required this.categoryName,
    required this.animationController,
    this.onItemUploaded,
    required this.maxImageCount,
    this.isFromChat
  }) : super(key: key);

  final AnimationController? animationController;
  final String? flag;
  final Product? item;
  final String categoryId;
  final String categoryName;
  final Function? onItemUploaded;
  final int maxImageCount;
  final bool? isFromChat;

  @override
  State<StatefulWidget> createState() => ItemEntryViewState();
}

class ItemEntryViewState extends State<CustomItemEntryView> {
  @override
  Widget build(BuildContext context) {
    return ItemEntryView(
        flag: widget.flag,
        item: widget.item,
        categoryId: widget.categoryId,
        categoryName: widget.categoryName,
        onItemUploaded: widget.onItemUploaded,
        animationController: widget.animationController,
        maxImageCount: widget.maxImageCount,
        isFromChat: widget.isFromChat);
  }
}
