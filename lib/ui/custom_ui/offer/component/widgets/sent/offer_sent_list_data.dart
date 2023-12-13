import 'package:flutter/material.dart';

import '../../../../../vendor_ui/offer/component/widgets/sent/offer_sent_list_data.dart';

class CustomOfferSentListData extends StatefulWidget {
  const CustomOfferSentListData({required this.animationController});
  final AnimationController animationController;
  @override
  State<StatefulWidget> createState() => _OfferSentListDataView();
}

class _OfferSentListDataView extends State<CustomOfferSentListData> {
  @override
  Widget build(BuildContext context) {
    return OfferSentListData(animationController: widget.animationController);
  }
}
