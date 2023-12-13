import 'package:flutter/material.dart';

import '../../../../../core/vendor/provider/promotion/item_promotion_provider.dart';
import '../../../../../core/vendor/viewobject/product.dart';
import '../../../../vendor_ui/item/promote/view/credit_card_view.dart';

class CustomCreditCardView extends StatefulWidget {
  const CustomCreditCardView(
      {Key? key,
      required this.product,
      required this.amount,
      required this.howManyDay,
      required this.paymentMethod,
      required this.stripePublishableKey,
      required this.startDate,
      required this.startTimeStamp,
      required this.itemPaidHistoryProvider})
      : super(key: key);

  final Product product;
  final String? amount;
  final String? howManyDay;
  final String paymentMethod;
  final String? stripePublishableKey;
  final String? startDate;
  final String startTimeStamp;
  final ItemPromotionProvider itemPaidHistoryProvider;

  @override
  State<StatefulWidget> createState() {
    return CreditCardViewState();
  }
}

class CreditCardViewState extends State<CustomCreditCardView> {
  @override
  Widget build(BuildContext context) {
    return CreditCardView(
        product: widget.product,
        amount: widget.amount,
        howManyDay: widget.howManyDay,
        paymentMethod: widget.paymentMethod,
        stripePublishableKey: widget.stripePublishableKey,
        startDate: widget.startDate,
        startTimeStamp: widget.startTimeStamp,
        itemPaidHistoryProvider: widget.itemPaidHistoryProvider);
  }
}
