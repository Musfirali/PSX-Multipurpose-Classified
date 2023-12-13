import 'package:flutter/material.dart';

import '../../../../../vendor_ui/user/profile/component/product_list/active_product_list_widget.dart';

class CustomActiveProductListWidget extends StatelessWidget {
  const CustomActiveProductListWidget(
      {Key? key, required this.animationController})
      : super(key: key);

  final AnimationController? animationController;

  @override
  Widget build(BuildContext context) {
    return ActiveProductListWidget(animationController: animationController);
  }
}
