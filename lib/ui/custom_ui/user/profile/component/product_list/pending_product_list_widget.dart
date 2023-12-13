import 'package:flutter/material.dart';

import '../../../../../vendor_ui/user/profile/component/product_list/pending_product_list_widget.dart';

class CustomPendingProductListWidget extends StatelessWidget {
  const CustomPendingProductListWidget(
      {Key? key, required this.animationController})
      : super(key: key);

  final AnimationController? animationController;

  @override
  Widget build(BuildContext context) {
    return PendingProductListWidget(animationController: animationController);
  }
}
