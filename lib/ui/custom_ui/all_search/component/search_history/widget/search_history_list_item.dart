import 'package:flutter/material.dart';

import '../../../../../../core/vendor/viewobject/search_history.dart';
import '../../../../../vendor_ui/all_search/component/search_history/widget/search_history_list_item.dart';

class CustomSerachHistoryListItem extends StatelessWidget {
  const CustomSerachHistoryListItem({
    Key? key,
    required this.history,
    this.animationController,
    this.animation,
    required this.isSelected,
    required this.onLongPress,
    required this.onTap,
  }) : super(key: key);

  final SearchHistory history;
  final AnimationController? animationController;
  final Animation<double>? animation;
  final bool isSelected;
  final Function onLongPress;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return SerachHistoryListItem(
        history: history,
        animation: animation,
        animationController: animationController,
        isSelected: isSelected,
        onLongPress: onLongPress,
        onTap: onTap);
  }
}
