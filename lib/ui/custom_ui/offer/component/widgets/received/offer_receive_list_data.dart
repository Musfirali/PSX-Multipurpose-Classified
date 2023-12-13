import 'package:flutter/material.dart';

import '../../../../../vendor_ui/offer/component/widgets/received/offer_receive_list_data.dart';

class CustomOfferReceivedListData extends StatefulWidget {
  const CustomOfferReceivedListData({required this.animationController});
  final AnimationController animationController;
  @override
  State<StatefulWidget> createState() => _OfferReceivedListViewState();
}

class _OfferReceivedListViewState extends State<CustomOfferReceivedListData> {
  @override
  Widget build(BuildContext context) {
    return OfferReceivedListData(
        animationController: widget.animationController);
  }
}
