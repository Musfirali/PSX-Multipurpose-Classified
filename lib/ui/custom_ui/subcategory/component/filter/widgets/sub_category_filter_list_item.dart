import 'package:flutter/material.dart';

import '../../../../../../core/vendor/viewobject/sub_category.dart';
import '../../../../../vendor_ui/subcategory/component/filter/widgets/sub_category_filter_list_item.dart';

class CustomSubCategorySearchListItem extends StatelessWidget {
  const CustomSubCategorySearchListItem(
      {Key? key,
      required this.subCategory,
      this.onTap,
      this.animationController,
      this.animation,
      this.isLoading = false,
      required this.isSelected})
      : super(key: key);

  final SubCategory subCategory;
  final Function? onTap;
  final AnimationController? animationController;
  final Animation<double>? animation;
  final bool isLoading;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return SubCategorySearchListItem(
      subCategory: subCategory,
      animation: animation,
      animationController: animationController,
      onTap: onTap,
      isLoading: isLoading,
      isSelected: isSelected,
    );
  }
}
