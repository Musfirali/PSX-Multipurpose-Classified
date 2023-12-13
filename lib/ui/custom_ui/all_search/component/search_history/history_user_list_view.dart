import 'package:flutter/material.dart';

import '../../../../vendor_ui/all_search/component/search_history/history_user_list_view.dart';


class CustomHistoryUserListView extends StatefulWidget {
  const CustomHistoryUserListView({
    Key? key,
  }) : super(key: key);

  @override
  _CustomHistoryUserListViewState createState() => _CustomHistoryUserListViewState();
}

class _CustomHistoryUserListViewState extends State<CustomHistoryUserListView>
    with SingleTickerProviderStateMixin {
 
  @override
  Widget build(BuildContext context) {
  
    return const HistoryUserListView();
  }
}
