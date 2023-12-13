import 'package:flutter/material.dart';

import '../../../../../vendor_ui/user/blocked_user/component/widgets/blocked_user_list_data.dart';

class CustomBlockUserListData extends StatelessWidget {
  const CustomBlockUserListData({required this.animationController});
  final AnimationController animationController;
  @override
  Widget build(BuildContext context) {
    return BlockUserListData(animationController: animationController);
  }
}
