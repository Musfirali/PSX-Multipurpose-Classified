import 'package:flutter/material.dart';

import '../../../../../vendor_ui/user/follow/component/follower/follower_user_list.dart';

class CustomFollowerUserList extends StatelessWidget {
  const CustomFollowerUserList({required this.animationController});
  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    return FollowerUserList(
      animationController: animationController,
    );
  }
}
