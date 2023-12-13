import 'package:flutter/material.dart';

import '../../../../../../core/vendor/viewobject/search_history.dart';
import '../../../../../vendor_ui/all_search/component/search_result/history/search_history_item.dart';

class CustomSearchHistoryTextItem extends StatelessWidget {
  const CustomSearchHistoryTextItem({required this.searchHistory});
  final SearchHistory searchHistory;
  @override
  Widget build(BuildContext context) {
    return SearchHistoryTextItem(searchHistory: searchHistory);
  }
}
