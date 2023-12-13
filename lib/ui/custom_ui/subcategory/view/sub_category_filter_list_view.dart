import 'package:flutter/material.dart';

import '../../../vendor_ui/subcategory/view/sub_category_filter_list_view_container.dart';

class CustomSubCategoryFilterListViewContainer extends StatefulWidget {
  const CustomSubCategoryFilterListViewContainer(
      {required this.categoryId, required this.selectedSubCatName});

  final String categoryId;
  final String selectedSubCatName;
  @override
  State<StatefulWidget> createState() {
    return _SubCategorySearchListViewState();
  }
}

class _SubCategorySearchListViewState
    extends State<CustomSubCategoryFilterListViewContainer> {
  @override
  Widget build(BuildContext context) {
    return SubCategoryFilterListViewContainer(
      categoryId: widget.categoryId,
      selectedSubCatName: widget.selectedSubCatName,
    );
  }
}