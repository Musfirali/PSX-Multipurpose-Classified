import 'package:flutter/material.dart';

import '../../../../../vendor_ui/subcategory/component/vertical/widgets/sub_category_vertical_data.dart';

class CustomSubCategoryVerticalData extends StatelessWidget {
  const CustomSubCategoryVerticalData(
      {required this.animationController});
  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    return SubCategoryVerticalData(animationController: animationController);
  }
}
