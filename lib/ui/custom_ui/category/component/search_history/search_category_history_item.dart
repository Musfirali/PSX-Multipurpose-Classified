import 'package:flutter/material.dart';

import '../../../../../core/vendor/viewobject/search_category_history.dart';
import '../../../../vendor_ui/category/component/search_history/search_category_history_item.dart';

class CustomSearchCategoryHistoryItem extends StatelessWidget {
  const CustomSearchCategoryHistoryItem(
      {required this.searchCategoryHistory});
  final SearchCategoryHistory searchCategoryHistory;

  @override
  Widget build(BuildContext context) {
    return SearchCategoryHistoryItem(
      searchCategoryHistory: searchCategoryHistory,
    );
  }
}
