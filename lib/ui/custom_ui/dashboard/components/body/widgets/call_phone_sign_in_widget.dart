import 'package:flutter/material.dart';

import '../../../../../vendor_ui/dashboard/components/body/widgets/call_phone_sign_in_widget.dart';

class CustomCallPhoneSignInWidget extends StatelessWidget {
  const CustomCallPhoneSignInWidget({required this.animationController, required this.currentIndex, required this.updateSelectedIndexWithAnimation, required this.updatePhoneInfo});
  final AnimationController animationController;
  final int currentIndex;
  final Function updateSelectedIndexWithAnimation;
  final Function updatePhoneInfo;
  @override
  Widget build(BuildContext context) {
    return CallPhoneSignInWidget(
      animationController: animationController,
      currentIndex: currentIndex,
      updatePhoneInfo: updatePhoneInfo,
      updateSelectedIndexWithAnimation: updateSelectedIndexWithAnimation,
    );
  }

}