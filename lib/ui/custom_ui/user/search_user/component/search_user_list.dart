import 'package:flutter/material.dart';

import '../../../../vendor_ui/user/search_user/component/search_user_list.dart';

class CustomSearchUserListData extends StatelessWidget {
  const CustomSearchUserListData({required this.animationController});
  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    return SearchUserListData(
      animationController: animationController,
    );
  }
}
