import 'package:flutter/material.dart';

import '../../../../../vendor_ui/user/follow/component/following/following_user_list.dart';

class CustomFollowingUserList extends StatelessWidget {
  const CustomFollowingUserList({required this.animationController});
  final AnimationController animationController;
  @override
  Widget build(BuildContext context) {
    return FollowingUserList(animationController: animationController);
  }
}
