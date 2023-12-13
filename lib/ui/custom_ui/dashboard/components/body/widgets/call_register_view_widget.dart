import 'package:flutter/material.dart';

import '../../../../../vendor_ui/dashboard/components/body/widgets/call_register_view_widget.dart';

class CustomCallRegisterView extends StatelessWidget {
  const CustomCallRegisterView(
      {required this.animationController,
      required this.currentIndex,
      required this.updateSelectedIndexWithAnimationUserId,
      required this.updateSelectedIndexWithAnimation});
  final AnimationController animationController;
  final int currentIndex;
  final Function updateSelectedIndexWithAnimationUserId;
  final Function updateSelectedIndexWithAnimation;

  @override
  Widget build(BuildContext context) {
    return CallRegisterView(
      animationController: animationController,
      currentIndex: currentIndex,
      updateSelectedIndexWithAnimation: updateSelectedIndexWithAnimation,
      updateSelectedIndexWithAnimationUserId:
          updateSelectedIndexWithAnimationUserId,
    );
  }
}
