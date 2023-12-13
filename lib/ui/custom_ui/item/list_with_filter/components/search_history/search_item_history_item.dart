import 'package:flutter/material.dart';

import '../../../../../../core/vendor/viewobject/search_item_history.dart';
import '../../../../../vendor_ui/item/list_with_filter/components/search_history/search_item_history_item.dart';

class CustomSearchItemHistoryItem extends StatelessWidget {
  const CustomSearchItemHistoryItem(
      {required this.searchItemHistory});
  final SearchItemHistory searchItemHistory;

  @override
  Widget build(BuildContext context) {
    return SearchItemHistoryItem(
      searchItemHistory: searchItemHistory);
  }
}
