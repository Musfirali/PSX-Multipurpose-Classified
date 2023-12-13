import 'package:flutter/material.dart';

import '../../../../vendor_ui/user/top_seller/view/top_seller_vertical_list_view.dart';

class CustomTopSellerVerticalListViewContainer extends StatefulWidget {
  const CustomTopSellerVerticalListViewContainer();
  @override
  State<StatefulWidget> createState() {
    return _TopSellerVerticalListViewContainer();
  }
}

class _TopSellerVerticalListViewContainer
    extends State<CustomTopSellerVerticalListViewContainer>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return const TopSellerVerticalListViewContainer();
  }
}
