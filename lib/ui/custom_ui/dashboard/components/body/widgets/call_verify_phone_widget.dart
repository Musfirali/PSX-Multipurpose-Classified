import 'package:flutter/material.dart';

import '../../../../../vendor_ui/dashboard/components/body/widgets/call_verify_phone_widget.dart';

class CustomCallVerifyPhoneWidget extends StatelessWidget {
  const CustomCallVerifyPhoneWidget(
      {this.userName,
      this.phoneNumber,
      required this.phoneId,
      required this.updateCurrentIndex,
      required this.updateUserCurrentIndex,
      required this.animationController,
      required this.currentIndex});

  final String? userName;
  final String? phoneNumber;
  final String phoneId;
  final Function updateCurrentIndex;
  final Function updateUserCurrentIndex;
  final int? currentIndex;
  final AnimationController? animationController;

  @override
  Widget build(BuildContext context) {
    return CallVerifyPhoneWidget(
        userName: userName,
        phoneNumber: phoneNumber,
        phoneId: phoneId,
        updateCurrentIndex: updateCurrentIndex,
        updateUserCurrentIndex: updateUserCurrentIndex,
        animationController: animationController,
        currentIndex: currentIndex);
  }
}
