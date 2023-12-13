import 'package:flutter/material.dart';

import '../../../vendor_ui/offer/component/offer_list_view.dart';

class CustomOfferListView extends StatefulWidget {
  const CustomOfferListView({
    Key? key,
    required this.animationController,
  }) : super(key: key);

  final AnimationController? animationController;
  @override
  _OfferListViewState createState() => _OfferListViewState();
}

class _OfferListViewState extends State<CustomOfferListView> {
  @override
  Widget build(BuildContext context) {
    return OfferListView(animationController: widget.animationController);
  }
}
