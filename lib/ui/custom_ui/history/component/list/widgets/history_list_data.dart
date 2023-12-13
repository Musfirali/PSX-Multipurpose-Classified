import 'package:flutter/material.dart';

import '../../../../../../core/vendor/viewobject/selection.dart';
import '../../../../../vendor_ui/history/component/list/widgets/history_list_data.dart';

class CustomHistoryListData extends StatelessWidget {
  const CustomHistoryListData(
      {required this.animationController,
      required this.isSelected,
      required this.onTap,
      required this.onLongPrass,
      required this.productSelection});
  final AnimationController animationController;
  final bool isSelected;
  final Function onTap;
  final List<Selection> productSelection;
  final Function onLongPrass;

  @override
  Widget build(BuildContext context) {
    return HistoryListData(
        animationController: animationController,
        isSelected: isSelected,
        onTap: onTap,
        onLongPrass: onLongPrass,
        productSelection: productSelection);
  }
}
