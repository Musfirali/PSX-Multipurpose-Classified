import 'package:flutter/material.dart';

import '../../../../../../core/vendor/viewobject/product.dart';
import '../../../../../vendor_ui/history/component/list/widgets/history_list_item.dart';

class CustomHistoryListItem extends StatelessWidget {
  const CustomHistoryListItem({
    Key? key,
    required this.product,
    required this.animationController,
    required this.isSelected,
    required this.onLongPress,
    required this.onTap,
  }) : super(key: key);

  final Product product;
  final AnimationController? animationController;
  final bool isSelected;
  final Function onLongPress;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return HistoryListItem(
        product: product,
        animationController: animationController,
        isSelected: isSelected,
        onLongPress: onLongPress,
        onTap: onTap);
  }
}
