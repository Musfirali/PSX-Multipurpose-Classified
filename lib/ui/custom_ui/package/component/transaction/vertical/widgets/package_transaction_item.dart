import 'package:flutter/material.dart';

import '../../../../../../../core/vendor/viewobject/buyadpost_transaction.dart';
import '../../../../../../vendor_ui/package/component/transaction/vertical/widgets/package_transaction_item.dart';

class CustomPackageTransactionItem extends StatelessWidget {
  const CustomPackageTransactionItem({Key? key, required this.transaction,
    required this.isSelected,
    required this.onLongPress,
    required this.onTap})
      : super(key: key);

  final PackageTransaction transaction;
  final bool isSelected;
  final Function onLongPress;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return PackageTransactionItem(transaction: transaction,
    isSelected: isSelected,
    onLongPress: onLongPress,
    onTap: onTap,
    );
  }
}
