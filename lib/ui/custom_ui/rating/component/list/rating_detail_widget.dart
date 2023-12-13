import 'package:flutter/material.dart';

import '../../../../vendor_ui/rating/component/list/rating_detail_widget.dart';

class CustomUserRatingDetailWidget extends StatefulWidget {
  const CustomUserRatingDetailWidget({Key? key}) : super(key: key);

  @override
  _HeaderWidgetState createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<CustomUserRatingDetailWidget> {
  @override
  Widget build(BuildContext context) {
    return const UserRatingDetailWidget();
  }
}
