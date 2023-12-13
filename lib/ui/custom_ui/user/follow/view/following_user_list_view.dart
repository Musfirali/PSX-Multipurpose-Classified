import 'package:flutter/material.dart';

import '../../../../vendor_ui/user/follow/view/following_user_list_view.dart';

class CustomFollowingUserListView extends StatefulWidget {
  @override
  _FollowingUserListViewState createState() {
    return _FollowingUserListViewState();
  }
}

class _FollowingUserListViewState extends State<CustomFollowingUserListView> {
  @override
  Widget build(BuildContext context) {
    return FollowingUserListView();
  }
}
