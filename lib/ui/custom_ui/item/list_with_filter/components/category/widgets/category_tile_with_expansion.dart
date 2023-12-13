import 'package:flutter/material.dart';

import '../../../../../../../core/vendor/viewobject/category.dart';
import '../../../../../../vendor_ui/item/list_with_filter/components/category/widgets/category_tile_with_expansion.dart';

class CustomCategoryTileWithExpansion extends StatefulWidget {
  const CustomCategoryTileWithExpansion(
      {Key? key,
      this.selectedData,
      this.category,
      required this.onSubCategoryClick, 
      this.isLoading = false })
      : super(key: key);
  final dynamic selectedData;
  final Category? category;
  final Function onSubCategoryClick;
  final bool isLoading;
  
  @override
  State<CustomCategoryTileWithExpansion> createState() =>
      _CustomCategoryTileWithExpansionState();
}

class _CustomCategoryTileWithExpansionState
    extends State<CustomCategoryTileWithExpansion> {
  @override
  Widget build(BuildContext context) {
    return CategoryTileWithExpansion(
        onSubCategoryClick: widget.onSubCategoryClick,
        category: widget.category,
        selectedData: widget.selectedData, 
        isLoading: widget.isLoading);
  }
}
