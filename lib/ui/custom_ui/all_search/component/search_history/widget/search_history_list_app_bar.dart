import 'package:flutter/material.dart';

import '../../../../../vendor_ui/all_search/component/search_history/widget/search_history_list_app_bar.dart';


class CustomSerachHistoryListViewAppBar extends StatefulWidget {
  const CustomSerachHistoryListViewAppBar(
      {this.selectedIndex = 0,
      this.showElevation = true,
      this.iconSize = 24,
      required this.items,
      required this.onItemSelected,
      //this.chatFlag
      })
      : assert(items.length >= 2 && items.length <= 5);

  @override
  _CustomSerachHistoryListViewAppBarState createState() {
    return _CustomSerachHistoryListViewAppBarState(
        selectedIndexNo: selectedIndex,
        items: items,
        iconSize: iconSize,
        onItemSelected: onItemSelected);
  }

  final int selectedIndex;
  final double iconSize;
  final bool showElevation;
  final List<SerachHistoryListViewAppBarItem> items;
  final ValueChanged<int> onItemSelected;
  //final String? chatFlag;
}

class _CustomSerachHistoryListViewAppBarState extends State<CustomSerachHistoryListViewAppBar> {
  _CustomSerachHistoryListViewAppBarState(
      {required this.items,
      this.iconSize,
      this.selectedIndexNo,
      required this.onItemSelected});

  final double? iconSize;
  List<SerachHistoryListViewAppBarItem> items;
  int? selectedIndexNo;
  ValueChanged<int> onItemSelected;


  @override
  Widget build(BuildContext context) {
    return SerachHistoryListViewAppBar(
            items: widget.items,
      onItemSelected: widget.onItemSelected,
      iconSize: widget.iconSize,
      selectedIndex: widget.selectedIndex,
      showElevation: widget.showElevation,
    );
  }
}

