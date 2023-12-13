
import 'package:flutter/material.dart';

import '../../../../../core/vendor/viewobject/ps_app_info.dart';
import '../../../../vendor_ui/item/promote/view/in_app_purchase_view.dart';

class CustomInAppPurchaseView extends StatefulWidget {
  const CustomInAppPurchaseView(this.itemId, this.appInfo);
  final String? itemId;
  final PSAppInfo? appInfo;
  
  @override
  _InAppPurchaseViewState createState() => _InAppPurchaseViewState();
}

class _InAppPurchaseViewState extends State<CustomInAppPurchaseView> {
  @override
  Widget build(BuildContext context) {
    return InAppPurchaseView(
      widget.itemId,
      widget.appInfo,
    );
  }
}
