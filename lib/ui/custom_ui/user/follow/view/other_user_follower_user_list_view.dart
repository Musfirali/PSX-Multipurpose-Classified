import 'package:flutter/material.dart';

import '../../../../vendor_ui/user/follow/view/other_user_follower_user_list_view.dart';

class CustomDetailFollowerUserListView extends StatefulWidget {
  const CustomDetailFollowerUserListView({
    Key? key,
    required this.userId,
  }) : super(key: key);

  final String userId;
  @override
  _DetailFollowerUserListViewState createState() {
    return _DetailFollowerUserListViewState();
  }
}

class _DetailFollowerUserListViewState
    extends State<CustomDetailFollowerUserListView> {
  @override
  Widget build(BuildContext context) {
    return OtherUserFollowerListView(userId: widget.userId);
  }
}
