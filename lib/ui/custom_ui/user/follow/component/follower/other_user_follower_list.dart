import 'package:flutter/material.dart';

import '../../../../../vendor_ui/user/follow/component/follower/other_user_follower_list.dart';

class CustomOtherUserFollowerList extends StatelessWidget {
  const CustomOtherUserFollowerList({required this.animationController});
  final AnimationController animationController;
  @override
  Widget build(BuildContext context) {
    return OtherUserFollowerList(
      animationController: animationController,
    );
  }
}
