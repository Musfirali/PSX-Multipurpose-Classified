import 'package:flutter/material.dart';
import '../../../vendor_ui/category/view/category_filter_list_view_container.dart';

class CustomCategoryFilterListViewContainer extends StatefulWidget {
  const CustomCategoryFilterListViewContainer({
    required this.selectedCategoryName
  });
  final String selectedCategoryName;
  @override
  State<StatefulWidget> createState() {
    return _CustomCategoryFilterListViewState();
  }
}

class _CustomCategoryFilterListViewState
    extends State<CustomCategoryFilterListViewContainer> {

  @override
  Widget build(BuildContext context) {
    return CategoryFilterListViewContainer(
      selectedCategoryName: widget.selectedCategoryName,
    );
  }
}