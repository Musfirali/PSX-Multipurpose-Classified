import 'package:flutter/material.dart';

import '../../../../../../core/vendor/viewobject/selection.dart';
import '../../../../../vendor_ui/item/promotion_transaction/component/widgets/promotion_transaction_list_data.dart';

class CustomPromotionTransactionListData extends StatelessWidget {
  const CustomPromotionTransactionListData(
      {required this.isSelected,
      required this.onTap,
      required this.onLongPrass,
      required this.productSelection});
  final bool isSelected;
  final Function onTap;
  final List<Selection> productSelection;
  final Function onLongPrass;
  
  @override
  Widget build(BuildContext context) {
    return PromotionTransactionListData(
        isSelected: isSelected,
        onTap: onTap,
        onLongPrass: onLongPrass,
        productSelection: productSelection);
  }
}
