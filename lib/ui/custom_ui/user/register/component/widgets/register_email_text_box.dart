import 'package:flutter/material.dart';

import '../../../../../vendor_ui/user/register/component/widgets/register_email_text_box.dart';

class CustomRegisterEmailTextBox extends StatelessWidget {
  const CustomRegisterEmailTextBox({
    required this.emailText,
  });

  final TextEditingController? emailText;
  @override
  Widget build(BuildContext context) {
    return RegisterEmailTextBox(emailText: emailText);
  }
}
