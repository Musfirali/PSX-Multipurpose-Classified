import 'package:flutter/material.dart';

import '../../../../vendor_ui/item/following_user_item/component/follower_product_list_view.dart';

class CustomFollwerProductList extends StatelessWidget {
  const CustomFollwerProductList({required this.animationController});
  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    return FollwerProductList(animationController: animationController);
  }
}
