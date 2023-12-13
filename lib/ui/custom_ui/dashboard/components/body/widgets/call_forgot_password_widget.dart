import 'package:flutter/material.dart';

import '../../../../../vendor_ui/dashboard/components/body/widgets/call_forgot_password_widget.dart';

class CustomCallForgotPasswordView extends StatelessWidget {
  const CustomCallForgotPasswordView(
      {required this.animationController,
      required this.currentIndex,
      required this.updateSelectedIndexWithAnimation});
  final AnimationController animationController;
  final int currentIndex;
  final Function updateSelectedIndexWithAnimation;
  @override
  Widget build(BuildContext context) {
    return CallForgotPasswordView(
      animationController: animationController,
      currentIndex: currentIndex,
      updateSelectedIndexWithAnimation: updateSelectedIndexWithAnimation,
    );
  }
}
