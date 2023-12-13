import 'package:flutter/material.dart';

import '../../../vendor_ui/history/view/history_list_container.dart';

class CustomHistoryListContainerView extends StatefulWidget {
  @override
  _HistoryListContainerViewState createState() =>
      _HistoryListContainerViewState();
}

class _HistoryListContainerViewState
    extends State<CustomHistoryListContainerView> {
  @override
  Widget build(BuildContext context) {
    return HistoryListContainerView();
  }
}
