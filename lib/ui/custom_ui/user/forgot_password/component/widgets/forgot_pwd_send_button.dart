import 'package:flutter/material.dart';

import '../../../../../vendor_ui/user/forgot_password/component/widgets/forgot_pwd_send_button.dart';

class CustomForgotPwdSendButton extends StatelessWidget {
  const CustomForgotPwdSendButton({
    required this.userEmailController,
    required this.goToLoginSelected,
    this.onVerifyForgotPasswordSelected,
  });

  final TextEditingController userEmailController;
  final Function? goToLoginSelected;
  final Function? onVerifyForgotPasswordSelected;

  @override
  Widget build(BuildContext context) {
    return ForgotPwdSendButton(
        userEmailController: userEmailController,
        goToLoginSelected: goToLoginSelected,
        onVerifyForgotPasswordSelected: onVerifyForgotPasswordSelected,);
  }
}
