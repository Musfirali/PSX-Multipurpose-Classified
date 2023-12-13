import 'package:flutter/material.dart';

import '../../../../../vendor_ui/item/entry/category/view/entry_category_vertical_list_view_container.dart';

class CustomEntryCategoryVerticalListViewContainer extends StatelessWidget {
  const CustomEntryCategoryVerticalListViewContainer({
    this.isFromChat});
  final bool? isFromChat;

  @override
  Widget build(BuildContext context) {
    return EntryCategoryVerticalListViewContainer(
      isFromChat: isFromChat);
  }
}
