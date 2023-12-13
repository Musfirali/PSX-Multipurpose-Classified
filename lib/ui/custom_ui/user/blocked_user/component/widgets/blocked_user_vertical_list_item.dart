import 'package:flutter/material.dart';

import '../../../../../../core/vendor/viewobject/blocked_user.dart';
import '../../../../../vendor_ui/user/blocked_user/component/widgets/blocked_user_vertical_list_item.dart';

class CustomBlockedUserVerticalListItem extends StatelessWidget {
  const CustomBlockedUserVerticalListItem(
      {Key? key,
      required this.blockedUser,
      this.animationController,
      this.animation})
      : super(key: key);

  final BlockedUser blockedUser;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    return BlockedUserVerticalListItem(
        blockedUser: blockedUser,
        animationController: animationController,
        animation: animation);
  }
}
