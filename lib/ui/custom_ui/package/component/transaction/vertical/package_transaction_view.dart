import 'package:flutter/material.dart';

import '../../../../../../core/vendor/viewobject/selection.dart';
import '../../../../../vendor_ui/package/component/transaction/vertical/package_transaction_view.dart';

class CustomPackageTransactionList extends StatefulWidget {
    const CustomPackageTransactionList({Key? key,  required this.historySelection})
      : super(key: key);
  final List<Selection> historySelection;
  @override
  _BuyAdTransactionListViewState createState() =>
      _BuyAdTransactionListViewState();
}

class _BuyAdTransactionListViewState extends State<CustomPackageTransactionList> {
  @override
  Widget build(BuildContext context) {
    return PackageTransactionList(historySelection: widget.historySelection,);
  }
}
