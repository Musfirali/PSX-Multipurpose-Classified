import 'package:flutter/material.dart';

import '../../../../../core/vendor/viewobject/category.dart';
import '../../../../vendor_ui/subcategory/component/vertical/sub_category_vertical_view.dart';

class CustomSubCategoryVerticalView extends StatefulWidget {
  const CustomSubCategoryVerticalView({required this.category});
  final Category category;
  @override
  _SubCategoryVerticalViewState createState() =>
      _SubCategoryVerticalViewState();
}

class _SubCategoryVerticalViewState
    extends State<CustomSubCategoryVerticalView> {
  @override
  Widget build(BuildContext context) {
    return SubCategoryVerticalView(
      category: widget.category,
    );
  }
}
