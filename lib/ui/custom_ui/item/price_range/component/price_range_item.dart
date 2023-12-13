import 'package:flutter/material.dart';
import 'package:psxmpc/ui/vendor_ui/item/price_range/component/price_range_item.dart';

class CustomPriceRangeItem extends StatelessWidget {
  const CustomPriceRangeItem(
      {Key? key,
      required this.dollarCount,
      this.animationController,
      this.animation,
      required this.isSelected})
      : super(key: key);

  final int dollarCount;
  final AnimationController? animationController;
  final Animation<double>? animation;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return PriceRangeItem(
      dollarCount: dollarCount,
      isSelected: isSelected,
      animation: animation,
      animationController: animationController,
    );
  }
}
