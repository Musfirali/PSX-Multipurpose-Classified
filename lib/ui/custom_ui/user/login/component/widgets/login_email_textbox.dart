import 'package:flutter/material.dart';

import '../../../../../vendor_ui/user/login/component/widgets/login_email_textbox.dart';

class CustomLoginEmailTextBox extends StatelessWidget {
  const CustomLoginEmailTextBox({required this.emailController});
  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return LoginEmailTextBox(emailController: emailController);
  }
}
