import 'package:flutter/material.dart';

import '../../../../../../vendor_ui/user/paid_item_list/component/vertical/widgets/paid_ad_item_list.dart';

class CustomPaidAdItemList extends StatelessWidget {
  const CustomPaidAdItemList({required this.animationController});
  final AnimationController animationController;
  @override
  Widget build(BuildContext context) {
    return PaidAdItemList(animationController: animationController);
  }
}
