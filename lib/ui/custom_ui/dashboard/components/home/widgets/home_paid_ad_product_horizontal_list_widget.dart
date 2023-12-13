import 'package:flutter/material.dart';

import '../../../../../vendor_ui/dashboard/components/home/widgets/home_paid_ad_product_horizontal_list_widget.dart';

class CustomHomePaidAdProductHorizontalListWidget extends StatelessWidget {
  const CustomHomePaidAdProductHorizontalListWidget({
    Key? key,
    required this.animationController,
  }) : super(key: key);

  final AnimationController? animationController;

  @override
  Widget build(BuildContext context) {
    return HomePaidAdProductHorizontalListWidget(
        animationController: animationController);
  }
}

