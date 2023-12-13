import 'package:flutter/material.dart';

import '../../../../../vendor_ui/category/component/filter/widgets/category_filter_list_data.dart';

class CustomCategoryFilterListData extends StatefulWidget {
  const CustomCategoryFilterListData(
      {required this.animationController, required this.selectedName});
  final AnimationController animationController;
  final String selectedName;
  @override
  _CustomCategoryFilterListDataState createState() =>
      _CustomCategoryFilterListDataState();
}

class _CustomCategoryFilterListDataState
    extends State<CustomCategoryFilterListData> {
  @override
  Widget build(BuildContext context) {
    return CategoryFilterListData(
        animationController: widget.animationController,
        selectedName: widget.selectedName,);
  }
}
