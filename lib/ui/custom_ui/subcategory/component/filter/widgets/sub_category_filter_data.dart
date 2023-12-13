import 'package:flutter/material.dart';

import '../../../../../vendor_ui/subcategory/component/filter/widgets/sub_category_filter_data.dart';

class CustomSubCategoryFilterData extends StatefulWidget {
  const CustomSubCategoryFilterData(
      {required this.animationController, required this.selectedSubCatName});
  final AnimationController animationController;
  final String selectedSubCatName;
  @override
  _SubCategoryFilterData createState() => _SubCategoryFilterData();
}

class _SubCategoryFilterData extends State<CustomSubCategoryFilterData> {
  @override
  Widget build(BuildContext context) {
    return SubCategoryFilterData(
      animationController: widget.animationController,
      selectedSubCatName: widget.selectedSubCatName,
    );
  }
}
