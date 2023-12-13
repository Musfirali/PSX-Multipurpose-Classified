import 'package:flutter/material.dart';

import '../../../vendor_ui/noti/component/appbar_noti_icon.dart';

class CustomAppbarNotiIcon extends StatefulWidget {
  @override
  State<CustomAppbarNotiIcon> createState() =>
      _DashboardAppBarNotiListIconButtomState();
}

class _DashboardAppBarNotiListIconButtomState
    extends State<CustomAppbarNotiIcon> {
  @override
  Widget build(BuildContext context) {
    return AppbarNotiIcon();
  }
}
