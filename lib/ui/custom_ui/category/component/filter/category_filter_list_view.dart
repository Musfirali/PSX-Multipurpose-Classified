import 'package:flutter/material.dart';

import '../../../../vendor_ui/category/component/filter/category_filter_list_view.dart';

class CustomCategoryFilterListView extends StatelessWidget {
  const CustomCategoryFilterListView(
      {required this.animationController,
      required this.animation,
      required this.selectedName});
  final AnimationController animationController;
  final Animation<double> animation;
  final String selectedName;

  @override
  Widget build(BuildContext context) {
    return CategoryFilterListView(
      animationController: animationController,
      animation: animation,
      selectedName: selectedName,
    );
  }
}