import 'package:flutter/material.dart';

import '../../../../vendor_ui/user/paid_item_list/view/paid_ad_item_list_container.dart';

class CustomPaidItemListContainerView extends StatefulWidget {
  @override
  _PaidItemListContainerViewState createState() =>
      _PaidItemListContainerViewState();
}

class _PaidItemListContainerViewState
    extends State<CustomPaidItemListContainerView> {
  @override
  Widget build(BuildContext context) {
    return PaidItemListContainerView();
  }
}
