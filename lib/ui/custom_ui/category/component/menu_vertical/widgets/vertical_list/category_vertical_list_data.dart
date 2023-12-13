import 'package:flutter/material.dart';

import '../../../../../../vendor_ui/category/component/vertical/widgets/vertical_list/category_vertical_list_data.dart';

class CustomCategoryVerticalListData extends StatelessWidget {
  const CustomCategoryVerticalListData({required this.animationController});
  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    return CategoryVerticalListData(
      animationController: animationController,
    );
  }
}
