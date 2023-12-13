

import 'package:flutter/material.dart';

import '../../../../../vendor_ui/dashboard/components/home/widgets/home_discount_product_horizontal_list_widget.dart';

class CustomHomeDiscountProductHorizontalListWidget extends StatelessWidget {
  const CustomHomeDiscountProductHorizontalListWidget(
      {Key? key, required this.animationController})
      : super(key: key);

  final AnimationController? animationController;

  @override
  Widget build(BuildContext context) {
    return HomeDiscountProductHorizontalListWidget(
      animationController: animationController,
    );
  }
}

