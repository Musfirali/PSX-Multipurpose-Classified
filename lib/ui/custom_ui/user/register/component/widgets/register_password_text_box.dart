import 'package:flutter/material.dart';

import '../../../../../vendor_ui/user/register/component/widgets/register_password_text_box.dart';

class CustomRegisterPasswordTextBox extends StatelessWidget {
  const CustomRegisterPasswordTextBox({
    required this.passwordText,
  });

  final TextEditingController? passwordText;
  @override
  Widget build(BuildContext context) {
    return RegisterPasswordTextBox(passwordText: passwordText);
  }
}
