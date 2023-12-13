import 'package:flutter/material.dart';

import '../../../../../vendor_ui/user/paid_item_list/component/horizontal/paid_product_list_widget.dart';
class CustomPaidProductListWidget extends StatelessWidget {
  const CustomPaidProductListWidget({
    Key? key,
    required this.animationController,
  }) : super(key: key);

  final AnimationController? animationController;

  @override
  Widget build(BuildContext context) {
    return PaidProductListWidget(animationController: animationController);
  }
}
