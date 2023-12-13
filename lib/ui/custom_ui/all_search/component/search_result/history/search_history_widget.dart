import 'package:flutter/material.dart';

import '../../../../../../core/vendor/viewobject/search_history.dart';
import '../../../../../vendor_ui/all_search/component/search_result/history/search_history_widget.dart';

class CustomSearchHistoryListWidget extends StatelessWidget {
  const CustomSearchHistoryListWidget(
      {required this.title,
      required this.searchHistoryList,
      required this.hasLimit});
  final String title;
  final List<SearchHistory> searchHistoryList;
  final bool hasLimit;
  @override
  Widget build(BuildContext context) {
    return SearchHistoryListWidget(
        title: title, searchHistoryList: searchHistoryList, hasLimit: hasLimit);
  }
}
