import 'package:flutter/material.dart';

import '../../../../../vendor_ui/user/profile/component/product_list/sold_out_product_list_widget.dart';

class CustomSoldOutProductListWidget extends StatelessWidget {
  const CustomSoldOutProductListWidget(
      {Key? key, required this.animationController})
      : super(key: key);

  final AnimationController? animationController;

  @override
  Widget build(BuildContext context) {
    return SoldOutProductListWidget(animationController: animationController);
  }
}
