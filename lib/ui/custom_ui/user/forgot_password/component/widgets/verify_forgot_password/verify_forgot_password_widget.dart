import 'package:flutter/material.dart';

import '../../../../../../vendor_ui/user/forgot_password/component/widgets/verify_forgot_password/verify_forgot_password_widget.dart';

class CustomVerifyForgotPasswordWidget extends StatefulWidget {
  const CustomVerifyForgotPasswordWidget({
    required this.userEmail,
    required this.onUpdateForgotChangeSelected,
  });

  final String? userEmail;
  final Function? onUpdateForgotChangeSelected;

  @override
  __TextFieldAndButtonWidgetState createState() =>
      __TextFieldAndButtonWidgetState();
}

class __TextFieldAndButtonWidgetState
    extends State<CustomVerifyForgotPasswordWidget> {
  @override
  Widget build(BuildContext context) {
    return VerifyForgotPasswordWidget(
        userEmail: widget.userEmail,
        onUpdateForgotChangeSelected: widget.onUpdateForgotChangeSelected);
  }
}
