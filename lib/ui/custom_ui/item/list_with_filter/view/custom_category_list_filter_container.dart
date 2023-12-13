import 'package:flutter/material.dart';

import '../../../../vendor_ui/item/list_with_filter/view/category_list_filter_container.dart';

class CustomCategoryListFilterContainer extends StatefulWidget {
  const CustomCategoryListFilterContainer({
    Key? key,
    required this.selectedData,
  }) : super(key: key);
  final dynamic selectedData;

  @override
  State<CustomCategoryListFilterContainer> createState() =>
      _CustomCategoryListFilterContainerState();
}

class _CustomCategoryListFilterContainerState
    extends State<CustomCategoryListFilterContainer> {
  @override
  Widget build(BuildContext context) {
    return CategoryFilterListContainer(selectedData: widget.selectedData);
  }
}
