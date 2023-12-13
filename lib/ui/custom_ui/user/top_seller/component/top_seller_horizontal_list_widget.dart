import 'package:flutter/material.dart';

import '../../../../vendor_ui/user/top_seller/component/top_seller_horizontal_list_widget.dart';

class CustomTopSellerHorizontalListWidget extends StatelessWidget {
  const CustomTopSellerHorizontalListWidget(
      {Key? key, required this.animationController})
      : super(key: key);

  final AnimationController? animationController;
  @override
  Widget build(BuildContext context) {
    return TopSellerHorizontalListWidget(
        animationController: animationController);
  }
}
