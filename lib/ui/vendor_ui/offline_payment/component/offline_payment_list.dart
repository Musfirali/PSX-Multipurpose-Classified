import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/vendor/provider/offline_payment/offline_payment_method_provider.dart';
import '../../../../core/vendor/utils/ps_animation.dart';
import '../../../custom_ui/offline_payment/component/offline_payment_item.dart';

class OfflinePaymentList extends StatelessWidget {
  const OfflinePaymentList({required this.animationController});
  final AnimationController animationController;
  @override
  Widget build(BuildContext context) {
    final OfflinePaymentProvider provider =
        Provider.of<OfflinePaymentProvider>(context);
    final int count = provider.dataLength;
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return CustomOfflinePaymentItem(
            animationController: animationController,
            animation:
                curveAnimation(animationController, count: count, index: index),
            offlinePayment: provider.getListIndexOf(index),
          );
        },
        childCount: count,
      ),
    );
  }
}
