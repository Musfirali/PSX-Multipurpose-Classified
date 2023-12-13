import 'package:flutter/material.dart';

import '../../../../../core/vendor/viewobject/search_subcategory_history.dart';
import '../../../../vendor_ui/subcategory/component/search_history/search_subcategory_history_widget.dart';

class CustomSearchSubCategoryHistoryListWidget extends StatelessWidget {
  const CustomSearchSubCategoryHistoryListWidget(
      {required this.searchSubCategoryHistoryList});

  final List<SearchSubCategoryHistory> searchSubCategoryHistoryList;

  @override
  Widget build(BuildContext context) {
    return SearchSubCategoryHistoryListWidget(
      searchSubCategoryHistoryList: searchSubCategoryHistoryList,
    );
  }
}
