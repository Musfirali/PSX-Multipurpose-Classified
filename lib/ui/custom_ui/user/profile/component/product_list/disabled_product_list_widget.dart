import 'package:flutter/material.dart';

import '../../../../../vendor_ui/user/profile/component/product_list/disabled_product_list_widget.dart';

class CustomDisabledListingDataWidget extends StatelessWidget {
  const CustomDisabledListingDataWidget(
      {Key? key, required this.animationController})
      : super(key: key);

  final AnimationController? animationController;

  @override
  Widget build(BuildContext context) {
    return DisabledListingDataWidget(animationController: animationController);
  }
}
