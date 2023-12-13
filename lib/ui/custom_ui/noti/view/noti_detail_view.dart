import 'package:flutter/material.dart';

import '../../../../core/vendor/viewobject/noti.dart';
import '../../../vendor_ui/noti/view/noti_detail_view.dart';

class CustomNotiView extends StatefulWidget {
  const CustomNotiView({this.noti});
  final Noti? noti;

  @override
  _NotiViewState createState() => _NotiViewState();
}

class _NotiViewState extends State<CustomNotiView> {
  @override
  Widget build(BuildContext context) {
    return NotiView(
      noti: widget.noti,
    );
  }
}
