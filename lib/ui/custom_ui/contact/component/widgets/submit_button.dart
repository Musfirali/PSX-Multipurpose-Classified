import 'package:flutter/material.dart';

import '../../../../vendor_ui/contact/component/widgets/submit_button.dart';

class CustomSubmitButtonWidget extends StatelessWidget {
  const CustomSubmitButtonWidget({
    required this.nameText,
    required this.emailText,
    required this.messageText,
  });

  final TextEditingController nameText, emailText, messageText;

  @override
  Widget build(BuildContext context) {
    return SubmitButtonWidget(
      nameText: nameText,
      emailText: emailText,
      messageText: messageText,
    );
  }
}
