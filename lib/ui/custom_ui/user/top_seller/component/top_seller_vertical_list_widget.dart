import 'package:flutter/material.dart';
import '../../../../vendor_ui/user/top_seller/component/top_seller_vertical_list_widget.dart';

class CustomTopSellerVerticalListWidget extends StatelessWidget {
  const CustomTopSellerVerticalListWidget(
      {required this.animationController, required this.controller});

  final AnimationController animationController;
  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    return TopSellerVerticalListWidget(
        animationController: animationController, controller: controller);
  }
}
