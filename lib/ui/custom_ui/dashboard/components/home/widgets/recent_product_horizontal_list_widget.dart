import 'package:flutter/material.dart';

import '../../../../../vendor_ui/dashboard/components/home/widgets/recent_product_horizontal_list_widget.dart';

class CustomRecentProductHorizontalListWidget extends StatelessWidget {
  const CustomRecentProductHorizontalListWidget(
      {Key? key, required this.animationController})
      : super(key: key);

  final AnimationController? animationController;

  @override
  Widget build(BuildContext context) {
    return RecentProductHorizontalListWidget(
        animationController: animationController);
  }
}
