import 'package:flutter/material.dart';

import '../../../../vendor_ui/user/item_list/component/user_item_list.dart';

class CustomUserItemList extends StatelessWidget {
  const CustomUserItemList({required this.animationController});
  final AnimationController animationController;
  @override
  Widget build(BuildContext context) {
    return UserItemList(animationController: animationController);
  }
}
