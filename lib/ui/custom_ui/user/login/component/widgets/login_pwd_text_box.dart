import 'package:flutter/material.dart';

import '../../../../../vendor_ui/user/login/component/widgets/login_pwd_text_box.dart';

class CustomLoginPasswordTextBox extends StatelessWidget {
  const CustomLoginPasswordTextBox({required this.passwordController});
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return LoginPasswordTextBox(passwordController: passwordController);
  }
}
