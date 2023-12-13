import 'package:flutter/material.dart';

import '../../../vendor_ui/noti/view/noti_list_view_container.dart';

class CustomNotiListContainerView extends StatefulWidget {
  @override
  _NotiListContainerViewState createState() => _NotiListContainerViewState();
}

class _NotiListContainerViewState extends State<CustomNotiListContainerView> {
  @override
  Widget build(BuildContext context) {
    return NotiListContainerView();
  }
}
