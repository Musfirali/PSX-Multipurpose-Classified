import 'package:flutter/material.dart';

import '../../../vendor_ui/category/view/category_vertical_list_view_container.dart';

class CustomCategorySortingListViewContainer extends StatefulWidget {
  const CustomCategorySortingListViewContainer({this.keyword = ''});
  final String? keyword;
  @override
  _CustomCategorySortingListViewState createState() {
    return _CustomCategorySortingListViewState();
  }
}

class _CustomCategorySortingListViewState
    extends State<CustomCategorySortingListViewContainer> {
  @override
  Widget build(BuildContext context) {
    return CategorySortingListViewContainer(
      keyword: widget.keyword!,
    );
  }
}
