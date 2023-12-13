import 'package:flutter/material.dart';

import '../../../../vendor_ui/noti/component/list/noti_list_view.dart';

class CustomNotiListView extends StatefulWidget {
  @override
  _NotiListViewState createState() {
    return _NotiListViewState();
  }
}

class _NotiListViewState extends State<CustomNotiListView> {
  @override
  Widget build(BuildContext context) {
    return NotiListView();
  }
}
