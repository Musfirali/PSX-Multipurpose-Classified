import 'package:flutter/material.dart';

import '../../../../../vendor_ui/user/forgot_password/component/widgets/forgot_pwd_email_text_box.dart';

class CustomForgotPwdEmailTextBox extends StatelessWidget {
  const CustomForgotPwdEmailTextBox({
    required this.userEmailController,
  });

  final TextEditingController userEmailController;
  @override
  Widget build(BuildContext context) {
    return ForgotPwdEmailTextBox(userEmailController: userEmailController);
  }
}
