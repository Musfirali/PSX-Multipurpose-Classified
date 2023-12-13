import 'package:flutter/material.dart';

import '../../../../../vendor_ui/item/entry/category/component/entry_category_vertical_list_data.dart';

class CustomEntryCategoryVerticalListData extends StatelessWidget {
  const CustomEntryCategoryVerticalListData({
    required this.animationController,
    this.onItemUploaded,
    this.isFromChat});

  final AnimationController animationController;
  final Function? onItemUploaded;
  final bool? isFromChat;

  @override
  Widget build(BuildContext context) {
    return EntryCategoryVerticalListData(
      animationController: animationController,
      onItemUploaded: onItemUploaded,
      isFromChat: isFromChat,
    );
  }
}
