import 'package:flutter/material.dart';

import '../../../vendor_ui/offline_payment/component/offline_payment_list.dart';

class CustomOfflinePaymentList extends StatelessWidget {
  const CustomOfflinePaymentList({required this.animationController});
  final AnimationController animationController;
  @override
  Widget build(BuildContext context) {
    return OfflinePaymentList(
      animationController: animationController,
    );
  }
}
