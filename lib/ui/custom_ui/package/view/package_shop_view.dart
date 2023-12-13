import 'package:flutter/material.dart';

import '../../../vendor_ui/package/view/package_shop_view.dart';

class CustomPackageShopInAppPurchaseView extends StatefulWidget {
  const CustomPackageShopInAppPurchaseView(
      {required this.androidKeyList, required this.iosKeyList});
  final String? androidKeyList;
  final String? iosKeyList;

  @override
  _PackageShopInAppPurchaseViewState createState() =>
      _PackageShopInAppPurchaseViewState();
}

class _PackageShopInAppPurchaseViewState
    extends State<CustomPackageShopInAppPurchaseView> {

  @override
  Widget build(BuildContext context) {
    return PackageShopInAppPurchaseView(
        androidKeyList: widget.androidKeyList, iosKeyList: widget.iosKeyList);
  }
}
