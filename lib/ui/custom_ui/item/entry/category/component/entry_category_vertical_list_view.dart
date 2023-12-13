import 'package:flutter/material.dart';

import '../../../../../vendor_ui/item/entry/category/component/entry_category_vertical_list_view.dart';

class CutomEntryCategoryVerticalListView extends StatelessWidget {
  const CutomEntryCategoryVerticalListView({
    required this.animationController,
    this.onItemUploaded,
    this.isFromChat});

  final AnimationController animationController;
  final Function? onItemUploaded;
  final bool? isFromChat;

  @override
  Widget build(BuildContext context) {
    return EntryCategoryVerticalListView(
      animationController: animationController,
      onItemUploaded: onItemUploaded,
      isFromChat: isFromChat,
    ); 
  }
}
