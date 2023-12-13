import 'package:flutter/material.dart';

import '../../../../vendor_ui/category/component/horizontal/home_category_list_widget.dart';

class CustomHomeCategoryHorizontalListWidget extends StatelessWidget {
  const CustomHomeCategoryHorizontalListWidget(
      {Key? key,
      required this.animationController})
      : super(key: key);

  final AnimationController? animationController;
  @override
  Widget build(BuildContext context) {
    return HomeCategoryHorizontalListWidget(animationController: animationController);
  }
}
