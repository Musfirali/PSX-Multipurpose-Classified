import 'package:flutter/material.dart';

import '../../../../vendor_ui/user/follow/view/other_user_following_user_list_view.dart';

class CustomOtherUserFollowingListView extends StatefulWidget {
  const CustomOtherUserFollowingListView({
    Key? key,
    required this.userId,
  }) : super(key: key);

  final String userId;
  @override
  _DetailFollowingUserListViewState createState() {
    return _DetailFollowingUserListViewState();
  }
}

class _DetailFollowingUserListViewState
    extends State<CustomOtherUserFollowingListView> {
  @override
  Widget build(BuildContext context) {
    return OtherUserFollowingListView(
      userId: widget.userId,
    );
  }
}
