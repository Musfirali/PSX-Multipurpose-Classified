import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/vendor/viewobject/selection.dart';
import '../../../../../vendor_ui/all_search/component/search_history/widget/delete_and_select_all_widget.dart';

class CustomSearchHistoryDeleteAndSelectAllWidget extends StatelessWidget {
  const CustomSearchHistoryDeleteAndSelectAllWidget({
    Key? key,
    required this.isChecked,
    required this.isSelected,
    required this.historySelection,
    required this.onTap,
  }) : super(key: key);

  final bool isChecked;
  final bool isSelected;
  final List<Selection> historySelection;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return SearchHistoryDeleteAndSelectAllWidget(
        isChecked: isChecked,
        isSelected: isSelected,
        historySelection: historySelection,
        onTap: onTap);
  }
}
