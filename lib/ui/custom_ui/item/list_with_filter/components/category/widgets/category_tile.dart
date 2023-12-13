import 'package:flutter/material.dart';

import '../../../../../../../core/vendor/viewobject/category.dart';
import '../../../../../../vendor_ui/item/list_with_filter/components/category/widgets/category_tile.dart';

class CustomCategoryTile extends StatefulWidget {
  const CustomCategoryTile(
      {Key? key,
      this.selectedData,
      this.category,
      required this.onCategoryClick})
      : super(key: key);
  final dynamic selectedData;
  final Category? category;
  final Function onCategoryClick;
  
  @override
  State<CustomCategoryTile> createState() => _CustomCategoryTileState();
}

class _CustomCategoryTileState extends State<CustomCategoryTile> {
  @override
  Widget build(BuildContext context) {
    return CategoryTile(
      onCategoryClick: widget.onCategoryClick,
      category: widget.category,
      selectedData: widget.selectedData,
    );
  }
}
