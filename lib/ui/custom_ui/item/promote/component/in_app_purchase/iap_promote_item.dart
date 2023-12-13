import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

import '../../../../../vendor_ui/item/promote/component/in_app_purchase/iap_promote_item.dart';

class CustomIAPPromoteItem extends StatelessWidget {
  const CustomIAPPromoteItem({required this.prod, required this.onPressed});
  final ProductDetails prod;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return IAPPromoteItem(
      onPressed: onPressed,
      prod: prod,
    );
  }
}
