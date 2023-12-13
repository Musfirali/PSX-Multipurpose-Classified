import 'package:flutter/material.dart';

import '../../../../vendor_ui/subcategory/component/filter/sub_category_filter_list_view.dart';

class CustomSubCategoryFilterListView extends StatelessWidget {
  const CustomSubCategoryFilterListView(
      {required this.animationController, required this.selectedSubCatName});
  final AnimationController animationController;
  final String selectedSubCatName;

  @override
  Widget build(BuildContext context) {
    return SubCategoryFilterListView(
      animationController: animationController,
      selectedSubCatName: selectedSubCatName,
    );
  }
}
