import 'package:flutter/material.dart';

import '../../../../../../../core/vendor/viewobject/category.dart';
import '../../../../../../vendor_ui/category/component/vertical/widgets/vertical_list/category_vertical_list_item.dart';

class CustomCategoryVerticalListItem extends StatelessWidget {
  const CustomCategoryVerticalListItem(
      {Key? key,
      required this.category,
      required this.animationController,
      required this.animation,
      this.isLoading = false})
      : super(key: key);

  final Category category;
  final AnimationController? animationController;
  final Animation<double>? animation;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return CategoryVerticalListItem(
      animation: animation,
      animationController: animationController,
      category: category,
      isLoading: isLoading,
    );
  }
}
