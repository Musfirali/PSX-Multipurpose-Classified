import 'package:flutter/material.dart';

import '../../../../../vendor_ui/all_search/component/search_result/category/category_result_list_widget.dart';

class CustomCategoryResultListWidget extends StatelessWidget {
  const CustomCategoryResultListWidget({
    required this.animationController});
  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    return CategoryResultListWidget(animationController: animationController);
  }
}
