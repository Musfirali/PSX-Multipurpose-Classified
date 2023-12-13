import 'package:flutter/material.dart';

import '../../../../../../../core/vendor/viewobject/category.dart';
import '../../../../../vendor_ui/item/entry/category/component/entry_category_vertical_list_item.dart';

class CustomEntryCategoryVerticalListItem extends StatelessWidget {
  const CustomEntryCategoryVerticalListItem(
      {Key? key,
      required this.category,
      required this.animationController,
      required this.animation,
      this.isLoading = false,
      required this.currentIndex,
      this.onItemUploaded,
      this.isFromChat})
      : super(key: key);

  final Category category;
  final AnimationController? animationController;
  final Animation<double>? animation;
  final bool isLoading;
  final int currentIndex;
  final Function? onItemUploaded;
  final bool? isFromChat;

  @override
  Widget build(BuildContext context) {
    return EntryCategoryVerticalListItem (
      category: category,
      animationController: animationController,
      animation: animation,
      isLoading: isLoading,
      currentIndex: currentIndex,
      onItemUploaded: onItemUploaded,
      isFromChat: isFromChat 
    );
  }
}
