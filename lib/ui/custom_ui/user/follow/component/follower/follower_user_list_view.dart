import 'package:flutter/material.dart';

import '../../../../../vendor_ui/user/follow/component/follower/follower_user_list_view.dart';

class CustomFollowerUserListWidget extends StatelessWidget {
  const CustomFollowerUserListWidget(
      {Key? key, required this.animationController})
      : super(key: key);
  final AnimationController? animationController;
  
  @override
  Widget build(BuildContext context) {
    return FollowerUserListWidget(animationController: animationController);
  }
}
