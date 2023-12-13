import 'package:flutter/material.dart';

import '../../../../../vendor_ui/dashboard/components/home/widgets/nearest_product_horizontal_list_widget.dart';

class CustomNearestProductHorizontalListWidget extends StatelessWidget {
  const CustomNearestProductHorizontalListWidget(
      {Key? key, required this.animationController})
      : super(key: key);

  final AnimationController? animationController;

  @override
  Widget build(BuildContext context) {
    return NearestProductHorizontalListWidget(
        animationController: animationController);
  }
}
