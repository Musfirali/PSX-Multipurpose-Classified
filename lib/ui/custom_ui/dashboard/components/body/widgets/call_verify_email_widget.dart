import 'package:flutter/material.dart';

import '../../../../../vendor_ui/dashboard/components/body/widgets/call_verify_email_widget.dart';

class CustomCallVerifyEmailWidget extends StatelessWidget {
  const CustomCallVerifyEmailWidget(
      {required this.updateCurrentIndex,
      required this.updateUserCurrentIndex,
      required this.animationController,
      required this.currentIndex,
      required this.userId});
  final Function updateCurrentIndex;
  final Function updateUserCurrentIndex;
  final int? currentIndex;
  final AnimationController? animationController;
  final String? userId;

  @override
  Widget build(BuildContext context) {
    return CallVerifyEmailWidget(
      animationController: animationController,
      currentIndex: currentIndex,
      userId: userId,
      updateCurrentIndex: updateCurrentIndex,
      updateUserCurrentIndex: updateUserCurrentIndex,
    );
  }
}