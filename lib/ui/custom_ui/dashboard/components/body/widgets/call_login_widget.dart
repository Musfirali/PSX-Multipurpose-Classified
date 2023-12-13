import 'package:flutter/material.dart';

import '../../../../../vendor_ui/dashboard/components/body/widgets/call_login_widget.dart';

class CustomCallLoginWidget extends StatelessWidget {
  const CustomCallLoginWidget(
      {required this.animationController,
      required this.updateCurrentIndex,
      required this.updateUserCurrentIndex,
      required this.currentIndex});

  final Function updateCurrentIndex;
  final Function updateUserCurrentIndex;
  final AnimationController? animationController;
  final int? currentIndex;

  @override
  Widget build(BuildContext context) {
    return CallLoginWidget(
        animationController: animationController,
        updateCurrentIndex: updateCurrentIndex,
        updateUserCurrentIndex: updateUserCurrentIndex,
        currentIndex: currentIndex);
  }
}
