import 'package:flutter/material.dart';

import '../../../../../../core/vendor/viewobject/category.dart';
import '../../../../../vendor_ui/all_search/component/search_result/category/category_result_list_text_item.dart';

class CustomCategoryResultListItem extends StatelessWidget {
  const CustomCategoryResultListItem(
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
    return CategoryResultListItem(
        category: category,
        animationController: animationController,
        animation: animation,
        isLoading: isLoading,);
  }
}
