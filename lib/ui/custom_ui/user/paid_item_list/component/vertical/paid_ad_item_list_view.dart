import 'package:flutter/material.dart';

import '../../../../../vendor_ui/user/paid_item_list/component/vertical/paid_ad_item_list_view.dart';

class CustomPaidAdItemListView extends StatefulWidget {
  const CustomPaidAdItemListView({Key? key, required this.animationController})
      : super(key: key);
  final AnimationController? animationController;
  @override
  _PaidAdItemListView createState() => _PaidAdItemListView();
}

class _PaidAdItemListView extends State<CustomPaidAdItemListView> {
  @override
  Widget build(BuildContext context) {
    return PaidAdItemListView(animationController: widget.animationController);
  }
}
