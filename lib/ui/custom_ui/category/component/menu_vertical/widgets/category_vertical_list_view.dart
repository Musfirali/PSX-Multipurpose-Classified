import 'package:flutter/material.dart';

import '../../../../../vendor_ui/category/component/vertical/widgets/category_vertical_list_view.dart';

class CustomCategoryVerticalListView extends StatefulWidget {
  const CustomCategoryVerticalListView({required this.animationController});

  final AnimationController animationController;

  @override
  _CustomCategoryVerticalListViewState createState() =>
      _CustomCategoryVerticalListViewState();
}

class _CustomCategoryVerticalListViewState extends State<CustomCategoryVerticalListView> {
  @override
  Widget build(BuildContext context) {
    return CategoryVerticalListView(animationController: widget.animationController);
  }
}
