import 'package:flutter/material.dart';

import '../../../../../vendor_ui/item/detail/component/appbar/product_expandable_appbar.dart';

class CustomProductExpandableAppbar extends StatelessWidget {
  const CustomProductExpandableAppbar({required this.isReadyToShowAppBarIcons});
  final bool isReadyToShowAppBarIcons;

  @override
  Widget build(BuildContext context) {
    return ProductExpandableAppbar(
        isReadyToShowAppBarIcons: isReadyToShowAppBarIcons);
  }
}
