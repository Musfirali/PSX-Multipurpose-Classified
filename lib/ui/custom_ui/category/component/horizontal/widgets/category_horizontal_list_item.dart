import 'package:flutter/material.dart';

import '../../../../../../core/vendor/viewobject/category.dart';
import '../../../../../vendor_ui/category/component/horizontal/widgets/category_horizontal_list_item.dart';

class CustomCategoryHorizontalListItem extends StatelessWidget {
  const CustomCategoryHorizontalListItem({
    Key? key,
    required this.category,
    this.isLoading = false,
  }) : super(key: key);

  final Category category;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return CategoryHorizontalListItem(category: category, isLoading: isLoading);
  }
}
