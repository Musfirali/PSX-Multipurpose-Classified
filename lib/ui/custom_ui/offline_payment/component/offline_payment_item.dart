import 'package:flutter/material.dart';

import '../../../../core/vendor/viewobject/offline_payment.dart';
import '../../../vendor_ui/offline_payment/component/offline_payment_item.dart';

class CustomOfflinePaymentItem extends StatelessWidget {
  const CustomOfflinePaymentItem({
    Key? key,
    required this.offlinePayment,
    this.animationController,
    this.animation,
  }) : super(key: key);

  final OfflinePayment offlinePayment;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    return OfflinePaymentItem(
      offlinePayment: offlinePayment,
      animation: animation,
      animationController: animationController,
    );
  }
}
