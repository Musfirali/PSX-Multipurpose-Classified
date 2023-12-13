import 'package:flutter/material.dart';

import '../../../../../vendor_ui/user/login/component/widgets/login_button.dart';

class CustomLoginButton extends StatelessWidget {
  const CustomLoginButton({
    required this.emailController,
    required this.passwordController,
    required this.onProfileSelected,
    required this.callBackAfterLoginSuccess
  });
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final Function? onProfileSelected, callBackAfterLoginSuccess;
  @override
  Widget build(BuildContext context) {
    return LoginButton(
        emailController: emailController,
        passwordController: passwordController,
        onProfileSelected: onProfileSelected,
        callBackAfterLoginSuccess: callBackAfterLoginSuccess,);
  }
}
