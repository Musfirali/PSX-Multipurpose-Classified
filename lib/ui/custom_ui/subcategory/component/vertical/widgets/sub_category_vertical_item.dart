import 'package:flutter/material.dart';

import '../../../../../../core/vendor/viewobject/sub_category.dart';
import '../../../../../vendor_ui/subcategory/component/vertical/widgets/sub_category_vertical_item.dart';

class CustomSubCategoryGridItem extends StatefulWidget {
  const CustomSubCategoryGridItem(
      {Key? key,
      required this.subCategory,
      required this.animationController,
      required this.animation,
      this.isLoading = false})
      : super(key: key);

  final SubCategory subCategory;
  final AnimationController? animationController;
  final Animation<double>? animation;
  final bool isLoading;

  @override
  State<CustomSubCategoryGridItem> createState() => _SubCategoryGridItemState();
}

class _SubCategoryGridItemState extends State<CustomSubCategoryGridItem> {
  @override
  Widget build(BuildContext context) {
    return SubCategoryGridItem(
        subCategory: widget.subCategory,
        animationController: widget.animationController,
        animation: widget.animation,
        isLoading: widget.isLoading,);
  }
}
