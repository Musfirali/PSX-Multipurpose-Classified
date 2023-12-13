import 'package:flutter/material.dart';

import '../../../../vendor_ui/user/search_user/component/search_user_list_view.dart';

class CustomUserSearchListView extends StatelessWidget {
  const CustomUserSearchListView(
      {required this.animationController, required this.animation});
  final AnimationController animationController;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return UserSearchListView(
        animationController: animationController, animation: animation);
  }
}
