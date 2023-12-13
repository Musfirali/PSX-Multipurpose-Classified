
import 'package:flutter/material.dart';

import '../../../../core/vendor/provider/promotion/item_promotion_provider.dart';
import '../../../../core/vendor/viewobject/product.dart';
import '../../../vendor_ui/offline_payment/view/offline_payment_view.dart';

class CustomOfflinePaymentView extends StatefulWidget {
  const CustomOfflinePaymentView(
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
  _OfflinePaymentViewState createState() {
    return _OfflinePaymentViewState();
  }
}

class _OfflinePaymentViewState extends State<CustomOfflinePaymentView> {
  @override
  Widget build(BuildContext context) {
    return OfflinePaymentView(
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
