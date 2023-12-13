import 'package:flutter/material.dart';

import '../../../../../vendor_ui/user/user_detail/component/detail_info/other_user_detail_info_widget.dart';

class CustomOtherUserProfileDetailWidget extends StatelessWidget {
  const CustomOtherUserProfileDetailWidget({
    Key? key,
    this.animationController,
  }) : super(key: key);

  final AnimationController? animationController;
  @override
  Widget build(BuildContext context) {
    return OtherUserProfileDetailWidget(
      animationController: animationController,
    );
  }
}
