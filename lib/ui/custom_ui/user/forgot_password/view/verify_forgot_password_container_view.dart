import 'package:flutter/material.dart';

import '../../../../vendor_ui/user/forgot_password/view/verify_forgot_password_container_view.dart';

class CustomVerifyForgotPasswordContainerView extends StatefulWidget {
  const CustomVerifyForgotPasswordContainerView({
    required this.userEmail,
    });

  final String userEmail;

  @override
  _VerifyForgotPasswordContainerViewState createState() =>
      _VerifyForgotPasswordContainerViewState();
}

class _VerifyForgotPasswordContainerViewState extends State<CustomVerifyForgotPasswordContainerView> {

  @override
  Widget build(BuildContext context) {
    return VerifyForgotPasswordContainerView(
      userEmail: widget.userEmail,
    );
  }
}
