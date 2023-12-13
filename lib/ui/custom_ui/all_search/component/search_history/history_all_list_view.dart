import 'package:flutter/material.dart';
import '../../../../vendor_ui/all_search/component/search_history/history_all_list_view.dart';

class CustomHistoryAllListView extends StatefulWidget {
  const CustomHistoryAllListView({
    Key? key,
  }) : super(key: key);

  @override
  _CustomHistoryAllListViewState createState() => _CustomHistoryAllListViewState();
}

class _CustomHistoryAllListViewState extends State<CustomHistoryAllListView>
    with SingleTickerProviderStateMixin {
 
  @override
  Widget build(BuildContext context) {
    return const HistoryAllListView();
  }
}
