import 'package:flutter/material.dart';

import '../../../vendor_ui/rating/view/rating_list_view.dart';

class CustomRatingListView extends StatefulWidget {
  const CustomRatingListView({Key? key, required this.itemUserId})
      : super(key: key);
  final String itemUserId;

  @override
  _RatingListViewState createState() => _RatingListViewState();
}

class _RatingListViewState extends State<CustomRatingListView> {
  @override
  Widget build(BuildContext context) {
    return RatingListView(itemUserId: widget.itemUserId);
  }
}
