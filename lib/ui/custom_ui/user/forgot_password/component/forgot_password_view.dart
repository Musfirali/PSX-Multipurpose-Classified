import 'package:flutter/material.dart';

import '../../../../vendor_ui/user/forgot_password/component/forgot_password_view.dart';

class CustomForgotPasswordView extends StatefulWidget {
  const CustomForgotPasswordView({
    Key? key,
    this.animationController,
    this.goToLoginSelected,
    this.onVerifyForgotPasswordSelected,
  }) : super(key: key);
  final AnimationController? animationController;
  final Function? goToLoginSelected;
  final Function? onVerifyForgotPasswordSelected;

  @override
  _ForgotPasswordViewState createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<CustomForgotPasswordView> {

  @override
  Widget build(BuildContext context) {
    return ForgotPasswordView(
      animationController: widget.animationController,
      goToLoginSelected: widget.goToLoginSelected,
      onVerifyForgotPasswordSelected: widget.onVerifyForgotPasswordSelected,
    );
  }
}
