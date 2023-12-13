import 'package:flutter/material.dart';

import '../../../../../../../core/vendor/viewobject/holder/intent_holder/product_detail_intent_holder.dart';
import '../../../../../../../core/vendor/viewobject/paid_ad_item.dart';
import '../../../../../../vendor_ui/user/paid_item_list/component/vertical/widgets/paid_ad_item_vertical_list_item.dart';

class CustomPaidAdItemVerticalListItem extends StatelessWidget {
  const CustomPaidAdItemVerticalListItem(
      {Key? key,
      required this.paidAdItem,
      this.animationController,
      this.animation,
      this.productDetailIntentHolder,
      required this.tagKey,
      this.isLoading = false})
      : super(key: key);

  final PaidAdItem paidAdItem;
  final AnimationController? animationController;
  final Animation<double>? animation;
  final ProductDetailIntentHolder? productDetailIntentHolder;
  final String tagKey;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return PaidAdItemVerticalListItem(
      paidAdItem: paidAdItem,
      tagKey: tagKey,
      animation: animation,
      animationController: animationController,
      productDetailIntentHolder: productDetailIntentHolder,
      isLoading: isLoading,
    );
  }
}
