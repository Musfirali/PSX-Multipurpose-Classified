import 'package:flutter/material.dart';

import '../../../../../vendor_ui/dashboard/components/drawer/widgets/featured_product_menu_widget.dart';

class CustomFeaturedProductMenuWidget extends StatelessWidget {
  const CustomFeaturedProductMenuWidget(
      {this.updateSelectedIndexWithAnimation});
  final Function? updateSelectedIndexWithAnimation;

  @override
  Widget build(BuildContext context) {
    return FeaturedProductMenuWidget(
      updateSelectedIndexWithAnimation: updateSelectedIndexWithAnimation,
    );
  }
}
