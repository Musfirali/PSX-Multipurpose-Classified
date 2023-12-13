import 'package:flutter/material.dart';

import '../../../../../core/vendor/viewobject/package.dart';
import '../../../../vendor_ui/package/component/package/package_item.dart';

class CustomPackageItem extends StatelessWidget {
  const CustomPackageItem({
    Key? key,
    required this.package,
    required this.onTap,
    required this.priceWithCurrency,
  }) : super(key: key);

  final Package package;
  final Function? onTap;
  final String priceWithCurrency;

  @override
  Widget build(BuildContext context) {
    return PackageItem(
        package: package, onTap: onTap, priceWithCurrency: priceWithCurrency);
  }
}
