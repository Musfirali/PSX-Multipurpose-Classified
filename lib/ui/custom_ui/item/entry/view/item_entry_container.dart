import 'package:flutter/material.dart';

import '../../../../../core/vendor/viewobject/product.dart';
import '../../../../vendor_ui/item/entry/view/item_entry_container.dart';

class CustomItemEntryContainerView extends StatefulWidget {
  const CustomItemEntryContainerView({
    required this.flag,
    required this.item,
    required this.categoryId,
    required this.categoryName,
    required this.isFromChat
  });
  final String flag;
  final Product? item;
  final String categoryId;
  final String categoryName;
  final bool isFromChat;
  
  @override
  ItemEntryContainerViewState createState() => ItemEntryContainerViewState();
}

class ItemEntryContainerViewState extends State<CustomItemEntryContainerView> {
  @override
  Widget build(BuildContext context) {
    return ItemEntryContainerView(
      flag: widget.flag, 
      item: widget.item,
      categoryId: widget.categoryId,
      categoryName: widget.categoryName,
      isFromChat: widget.isFromChat);
  }
}
