import 'package:flutter/material.dart';

import '../../../../../vendor_ui/user/login/component/widgets/forgot_password_text_widget.dart';

class CustomForgotPasswordTextWidget extends StatelessWidget {
  const CustomForgotPasswordTextWidget({
    Key? key,
    this.onForgotPasswordSelected,
  }) : super(key: key);

  final Function? onForgotPasswordSelected;

  @override
  Widget build(BuildContext context) {
    return ForgotPasswordTextWidget(
      onForgotPasswordSelected: onForgotPasswordSelected,
    );
  }
}
