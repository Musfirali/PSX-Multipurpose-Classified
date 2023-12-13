import 'package:flutter/material.dart';

import '../../../../../core/vendor/provider/promotion/item_promotion_provider.dart';
import '../../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../../core/vendor/viewobject/product.dart';
import '../../../../vendor_ui/item/promote/view/pay_stack_view.dart';

class CustomPayStackView extends StatefulWidget {
  const CustomPayStackView(
      {Key? key,
      required this.product,
      required this.amount,
      required this.howManyDay,
      required this.paymentMethod,
      required this.stripePublishableKey,
      required this.startDate,
      required this.startTimeStamp,
      required this.itemPaidHistoryProvider,
      required this.userProvider,
      required this.payStackKey})
      : super(key: key);

  final Product product;
  final String? amount;
  final String? howManyDay;
  final String paymentMethod;
  final String? stripePublishableKey;
  final String? startDate;
  final String startTimeStamp;
  final ItemPromotionProvider itemPaidHistoryProvider;
  final UserProvider userProvider;
  final String? payStackKey;

  @override
  State<StatefulWidget> createState() {
    return PayStackViewState();
  }
}

class PayStackViewState extends State<CustomPayStackView> {
  @override
  Widget build(BuildContext context) {
    return PayStackView(
        product: widget.product,
        amount: widget.amount,
        howManyDay: widget.howManyDay,
        paymentMethod: widget.paymentMethod,
        stripePublishableKey: widget.stripePublishableKey,
        startDate: widget.startDate,
        startTimeStamp: widget.startTimeStamp,
        itemPaidHistoryProvider: widget.itemPaidHistoryProvider,
        userProvider: widget.userProvider,
        payStackKey: widget.payStackKey);
  }
}
