import 'package:flutter/material.dart';

import '../../../../vendor_ui/user/user_detail/component/other_user_product_vertical_list.dart';

class CustomOtherUserProductList extends StatelessWidget {
  const CustomOtherUserProductList({required this.animationController});
  final AnimationController animationController;
  @override
  Widget build(BuildContext context) {
    return OtherUserProductList(animationController: animationController);
  }
}
