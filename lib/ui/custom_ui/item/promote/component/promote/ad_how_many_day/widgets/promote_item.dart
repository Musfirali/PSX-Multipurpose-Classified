import 'package:flutter/material.dart';

import '../../../../../../../../core/vendor/viewobject/product.dart';
import '../../../../../../../vendor_ui/item/promote/component/promote/ad_how_many_day/widgets/promote_item.dart';

class CustomPromoteItem extends StatelessWidget {
  const CustomPromoteItem(
      {required this.onTap,
      required this.day,
      required this.product,
      required this.amount});
  final Function onTap;
  final String day;
  final String amount;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return PromoteItem(
       product:  product,
       onTap: onTap,
       day: day,
       amount: amount);
  }
}