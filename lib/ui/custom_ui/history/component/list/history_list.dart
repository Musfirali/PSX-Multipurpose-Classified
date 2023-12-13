import 'package:flutter/material.dart';

import '../../../../vendor_ui/history/component/list/history_list.dart';

class CustomHistoryListView extends StatefulWidget {
  const CustomHistoryListView({
    Key? key,
    required this.animationController,
  }) : super(key: key);
  final AnimationController? animationController;

  @override
  _HistoryListViewState createState() => _HistoryListViewState();
}

class _HistoryListViewState extends State<CustomHistoryListView> {
  @override
  Widget build(BuildContext context) {
    return HistoryListView(
      animationController: widget.animationController,
    );
  }
}
