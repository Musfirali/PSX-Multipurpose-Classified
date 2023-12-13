import 'package:flutter/material.dart';

import '../../../../vendor_ui/user/forgot_password/component/update_forgot_password_view.dart';

class CustomUpdateForgotPasswordView extends StatefulWidget {
  const CustomUpdateForgotPasswordView(
      {Key? key,
      required this.userId,
      this.goToLoginSelected,
      this.goToVerifyPasswordSelected})
      : super(key: key);

  final String userId;
  final Function? goToLoginSelected;
  final Function? goToVerifyPasswordSelected;

  @override
  _UpdateForgotPasswordViewState createState() =>
      _UpdateForgotPasswordViewState();
}

class _UpdateForgotPasswordViewState
    extends State<CustomUpdateForgotPasswordView> {
  @override
  Widget build(BuildContext context) {
    return UpdateForgotPasswordView(
        userId: widget.userId,
        goToLoginSelected: widget.goToLoginSelected,
        goToVerifyPasswordSelected: widget.goToVerifyPasswordSelected);
  }
}
