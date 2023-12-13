import 'package:flutter/material.dart';

import '../../../../vendor_ui/all_search/component/search_history/history_item_list_view.dart';


class CustomHistoryItemListView extends StatefulWidget {
  const CustomHistoryItemListView({
    Key? key,
  }) : super(key: key);

  @override
  _CustomHistoryItemListViewState createState() => _CustomHistoryItemListViewState();
}

class _CustomHistoryItemListViewState extends State<CustomHistoryItemListView>
    with SingleTickerProviderStateMixin {
 
  @override
  Widget build(BuildContext context) {
    return const HistoryItemListView();
  }
}
