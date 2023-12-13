import 'package:flutter/material.dart';

import '../../../../../../core/vendor/viewobject/category.dart';
import '../../../../../vendor_ui/category/component/filter/widgets/category_filter_list_item.dart';

class CustomCategoryFilterListItem extends StatelessWidget {
  const CustomCategoryFilterListItem(
      {Key? key,
      required this.category,
      required this.animationController,
      required this.animation,
      this.isLoading = false,
      required this.isSelected})
      : super(key: key);

  final Category category;
  final AnimationController? animationController;
  final Animation<double>? animation;
  final bool isLoading;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return CategoryFilterListItem(
      category: category,
      animationController: animationController,
      animation: animation,
      isLoading: isLoading,
      isSelected: isSelected,
    );
  }
}
