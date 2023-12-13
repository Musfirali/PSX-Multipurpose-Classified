import 'package:flutter/material.dart';

import '../../../../../../core/vendor/viewobject/selection.dart';
import '../../../../../vendor_ui/all_search/component/search_history/widget/search_history_list_data.dart';

class CustomSearchHistoryListData extends StatefulWidget {
  const CustomSearchHistoryListData(
      {required this.animationController,
      required this.historySelection,
      required this.isSelected,
      required this.onTap,
      required this.onLongPrass});
  final AnimationController animationController;
  final List<Selection> historySelection;
  final bool isSelected;
  final Function onTap;
  final Function onLongPrass;

  @override
  State<StatefulWidget> createState() => _CustomSearchHistoryListDataView();
}

class _CustomSearchHistoryListDataView
    extends State<CustomSearchHistoryListData> {
  @override
  Widget build(BuildContext context) {
    return SearchHistoryListData(
        animationController: widget.animationController,
        historySelection: widget.historySelection,
        isSelected: widget.isSelected,
        onLongPrass: widget.onLongPrass,
        onTap: widget.onTap);
  }
}
