import 'package:flutter/material.dart';

import '../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../vendor_ui/package/view/package_transaction_container.dart';

class CustomPackageTransactionContainerView extends StatefulWidget {
  @override
  _BuyAdTransactionContainerViewState createState() =>
      _BuyAdTransactionContainerViewState();
}

class _BuyAdTransactionContainerViewState
    extends State<CustomPackageTransactionContainerView> {
  AnimationController? animationController;
  late PsValueHolder valueHolder;

  @override
  Widget build(BuildContext context) {
    return PackageTransactionContainerView();
  }
}
