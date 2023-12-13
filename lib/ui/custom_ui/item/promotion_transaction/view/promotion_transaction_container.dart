import 'package:flutter/material.dart';

import '../../../../vendor_ui/item/promotion_transaction/view/promotion_transaction_container.dart';

class CustomPromotionTransactionContainerView extends StatefulWidget {
  @override
  _BuyAdTransactionContainerViewState createState() =>
      _BuyAdTransactionContainerViewState();
}

class _BuyAdTransactionContainerViewState
    extends State<CustomPromotionTransactionContainerView> {
  @override
  Widget build(BuildContext context) {
    return PromotionTransactionContainerView();
  }
}
