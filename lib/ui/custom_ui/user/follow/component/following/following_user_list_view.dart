import 'package:flutter/material.dart';

import '../../../../../vendor_ui/user/follow/component/following/following_user_list_view.dart';

class CustomFollowingUserListWidget extends StatelessWidget {
  const CustomFollowingUserListWidget(
      {Key? key, required this.animationController})
      : super(key: key);
  final AnimationController? animationController;
  @override
  Widget build(BuildContext context) {
    return FollowingUserListWidget(animationController: animationController);
  }
}
