import 'package:flutter/material.dart';

import '../../../../../vendor_ui/item/list_with_filter/components/category/category_filter_list.dart';

class CustomCategoryFilterList extends StatelessWidget {
  const CustomCategoryFilterList({
    Key? key,
    required this.onCategoryClick,
    required this.onSubCategoryClick,
    required this.selectedData,
  }) : super(key: key);
  final dynamic selectedData;
  final Function onSubCategoryClick;
  final Function onCategoryClick;

  @override
  Widget build(BuildContext context) {
    return CategoryFilterList(
        onCategoryClick: onCategoryClick,
        onSubCategoryClick: onSubCategoryClick,
        selectedData: selectedData);
  }
}
