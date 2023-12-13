import 'package:flutter/material.dart';

import '../../../../../../vendor_ui/user/forgot_password/component/widgets/update_forgot_password/update_forgot_pwd_button.dart';

class CustomUpdateForgotPasswordSaveButton extends StatelessWidget {
  const CustomUpdateForgotPasswordSaveButton(
      {required this.passwordController,
      required this.confirmPasswordController,
      required this.codeController,
      required this.userId,
      this.goToLoginSelected});

  final TextEditingController passwordController, confirmPasswordController,codeController;
  final String userId;
  final Function? goToLoginSelected;

  @override
  Widget build(BuildContext context) {
    return UpdateForgotPasswordSaveButton(
       codeController: codeController,
        passwordController: passwordController,
        confirmPasswordController: confirmPasswordController,
        goToLoginSelected: goToLoginSelected,
        userId: userId);
  }
}
