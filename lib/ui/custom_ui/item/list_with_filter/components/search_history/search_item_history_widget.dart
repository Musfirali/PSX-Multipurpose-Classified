import 'package:flutter/material.dart';

import '../../../../../../core/vendor/viewobject/search_item_history.dart';
import '../../../../../vendor_ui/item/list_with_filter/components/search_history/search_item_history_widget.dart';

class CustomSearchItemHistoryListWidget extends StatelessWidget {
  const CustomSearchItemHistoryListWidget(
      {required this.searchItemHistoryList});

  final List<SearchItemHistory> searchItemHistoryList;

  @override
  Widget build(BuildContext context) {
    return SearchItemHistoryListWidget(
      searchItemHistoryList: searchItemHistoryList,
    );
  }
}
