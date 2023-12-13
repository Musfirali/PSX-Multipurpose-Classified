import 'package:flutter/material.dart';

import '../../../../../../core/vendor/viewobject/promotion_transaction.dart';
import '../../../../../vendor_ui/item/promotion_transaction/component/widgets/promotion_transaction_item.dart';

class CustomPromotionTransactionItem extends StatelessWidget {
  const CustomPromotionTransactionItem({
    Key? key,
    required this.transaction,
    required this.isSelected,
    required this.onLongPress,
    required this.onTap,
  }) : super(key: key);

  final PromotionTransaction transaction;
  final bool isSelected;
  final Function onLongPress;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return PromotionTransactionItem(
        transaction: transaction,
        isSelected: isSelected,
        onLongPress: onLongPress,
        onTap: onTap);
  }
}
