import 'package:flutter/material.dart';

import '../../../../../core/vendor/viewobject/search_subcategory_history.dart';
import '../../../../vendor_ui/subcategory/component/search_history/search_subcategory_history_item.dart';

class CustomSearchSubCategoryHistoryItem extends StatelessWidget {
  const CustomSearchSubCategoryHistoryItem(
      {required this.searchSubCategoryHistory});
  final SearchSubCategoryHistory searchSubCategoryHistory;

  @override
  Widget build(BuildContext context) {
    return SearchSubCategoryHistoryItem(
      searchSubCategoryHistory: searchSubCategoryHistory,
    );
  }
}