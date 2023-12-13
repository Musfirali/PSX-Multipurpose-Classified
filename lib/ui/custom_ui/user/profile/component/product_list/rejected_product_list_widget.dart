import 'package:flutter/material.dart';

import '../../../../../vendor_ui/user/profile/component/product_list/rejected_product_list_widget.dart';

class CustomRejectedListingDataWidget extends StatelessWidget {
  const CustomRejectedListingDataWidget(
      {Key? key, required this.animationController})
      : super(key: key);

  final AnimationController? animationController;

  @override
  Widget build(BuildContext context) {
    return RejectedListingDataWidget(animationController: animationController);
  }
}
