import 'package:flutter/material.dart';

import '../../../../core/vendor/viewobject/category.dart';
import '../../../vendor_ui/subcategory/view/sub_category_vertical_view_container.dart';

class CustomSubCategoryGridView extends StatefulWidget {
  const CustomSubCategoryGridView({this.category});
  final Category? category;
  @override
  _ModelGridViewState createState() {
    return _ModelGridViewState();
  }
}

class _ModelGridViewState extends State<CustomSubCategoryGridView> {
  @override
  Widget build(BuildContext context) {
    return SubCategoryGridView(
      category: widget.category,
    );
  }
}
