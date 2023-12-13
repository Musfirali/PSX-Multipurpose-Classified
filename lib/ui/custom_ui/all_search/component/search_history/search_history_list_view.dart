import 'package:flutter/material.dart';

import '../../../../vendor_ui/all_search/component/search_history/search_history_list_view.dart';

class CustomSerchHistoryListView extends StatefulWidget {
  const CustomSerchHistoryListView({
    Key? key,
    required this.animationController,
  }) : super(key: key);

  final AnimationController? animationController;
  @override
  _CustomSerchHistoryListViewState createState() =>
      _CustomSerchHistoryListViewState();
}

class _CustomSerchHistoryListViewState
    extends State<CustomSerchHistoryListView> {
  @override
  Widget build(BuildContext context) {
    return SearchHistoryListView(
      animationController: widget.animationController,
    );
  }
}
