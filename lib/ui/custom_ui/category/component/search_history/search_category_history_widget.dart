import 'package:flutter/material.dart';

import '../../../../../core/vendor/viewobject/search_category_history.dart';
import '../../../../vendor_ui/category/component/search_history/search_category_history_widget.dart';

class CustomSearchCategoryHistoryListWidget extends StatelessWidget {
  const CustomSearchCategoryHistoryListWidget(
      {required this.searchCategoryHistoryList});

  final List<SearchCategoryHistory> searchCategoryHistoryList;

  @override
  Widget build(BuildContext context) {
    return SearchCategoryHistoryListWidget(
      searchCategoryHistoryList: searchCategoryHistoryList,
    );
  }
}
