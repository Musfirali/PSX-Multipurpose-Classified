import 'package:flutter/material.dart';

import '../../../../../core/vendor/viewobject/user.dart';
import '../../../../vendor_ui/user/follow/component/user_vertical_list_item.dart';

class CustomUserVerticalListItem extends StatelessWidget {
  const CustomUserVerticalListItem({
    Key? key,
    required this.user,
    this.animationController,
    this.animation,
    this.isLoading = false,
  }) : super(key: key);

  final User user;
  final AnimationController? animationController;
  final Animation<double>? animation;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return UserVerticalListItem(
      user: user,
      animation: animation,
      animationController: animationController,
      isLoading: isLoading,
    );
  }
}
