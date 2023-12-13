import 'package:flutter/material.dart';

import '../../../../vendor_ui/offer/component/widgets/offer_sent_list_view.dart';

class CustomOfferSentListView extends StatefulWidget {
  const CustomOfferSentListView({
    Key? key,
  }) : super(key: key);

  @override
  _OfferSentListViewState createState() => _OfferSentListViewState();
}

class _OfferSentListViewState extends State<CustomOfferSentListView> {
  @override
  Widget build(BuildContext context) {
    return const OfferSentListView();
  }
}
