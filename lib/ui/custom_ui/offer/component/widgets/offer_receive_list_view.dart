import 'package:flutter/material.dart';

import '../../../../vendor_ui/offer/component/widgets/offer_receive_list_view.dart';

class CustomOfferReceivedListView extends StatefulWidget {
  const CustomOfferReceivedListView({
    Key? key,
  }) : super(key: key);

  @override
  _OfferReceivedListViewState createState() => _OfferReceivedListViewState();
}

class _OfferReceivedListViewState extends State<CustomOfferReceivedListView> {
  @override
  Widget build(BuildContext context) {
    return const OfferReceivedListView();
  }
}
