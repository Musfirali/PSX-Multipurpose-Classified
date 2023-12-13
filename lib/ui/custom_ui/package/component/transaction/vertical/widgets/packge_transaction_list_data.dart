import 'package:flutter/material.dart';

import '../../../../../../../core/vendor/viewobject/selection.dart';
import '../../../../../../vendor_ui/package/component/transaction/vertical/widgets/packge_transaction_list_data.dart';

class CustomPackageTransactionListData extends StatelessWidget {
      const CustomPackageTransactionListData(
      {required this.animationController,
      required this.isSelected,
      required this.onTap,
      required this.onLongPrass,
      required this.productSelection});

  final AnimationController animationController;
  final bool isSelected;
  final Function onTap;
  final Function onLongPrass;
  final List<Selection> productSelection;
  
  @override
  Widget build(BuildContext context) {
    return PackageTransactionListData(
      isSelected: isSelected,
      onLongPrass: onLongPrass,
      onTap: onTap,
      productSelection: productSelection,
      animationController: animationController,
    );
  }
}
