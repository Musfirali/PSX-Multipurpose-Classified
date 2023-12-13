import 'package:flutter/material.dart';

import '../../../../vendor_ui/user/blocked_user/component/blocked_user_list_view.dart';

class CustomBlockedUserListView extends StatefulWidget {
  const CustomBlockedUserListView({Key? key, required this.animationController})
      : super(key: key);
  final AnimationController? animationController;
  @override
  _BlockedUserListViewState createState() {
    return _BlockedUserListViewState();
  }
}

class _BlockedUserListViewState extends State<CustomBlockedUserListView> {
  @override
  Widget build(BuildContext context) {
    return BlockedUserListView(
      animationController: widget.animationController,
    );
  }
}
