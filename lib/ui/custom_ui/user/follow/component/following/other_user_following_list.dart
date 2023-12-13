import 'package:flutter/material.dart';

import '../../../../../vendor_ui/user/follow/component/following/other_user_following_list.dart';

class CustomOtherUserFollowingList extends StatelessWidget {
  const CustomOtherUserFollowingList({required this.animationController});
  final AnimationController animationController;
  @override
  Widget build(BuildContext context) {
    return OtherUserFollowingList(animationController: animationController);
  }
}
