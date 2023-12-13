import 'package:flutter/material.dart';

import '../../../../vendor_ui/user/follow/view/follower_user_list_view.dart';

class CustomFollowerUserListView extends StatefulWidget {
  @override
  _FollowerUserListViewState createState() {
    return _FollowerUserListViewState();
  }
}

class _FollowerUserListViewState extends State<CustomFollowerUserListView> {
  @override
  Widget build(BuildContext context) {
    return FollowerUserListView();
  }
}
