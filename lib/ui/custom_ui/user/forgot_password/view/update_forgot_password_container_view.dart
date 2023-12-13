import 'package:flutter/material.dart';

import '../../../../vendor_ui/user/forgot_password/view/update_forgot_password_container_view.dart';

class CustomUpdateForgotPasswordContainerView extends StatefulWidget {
  const CustomUpdateForgotPasswordContainerView({
    Key? key,
    required this.userId,
  }) : super(key: key);

  final String userId;

  @override
  _UpdateForgotPasswordContainerViewState createState() =>
      _UpdateForgotPasswordContainerViewState();
}

class _UpdateForgotPasswordContainerViewState
    extends State<CustomUpdateForgotPasswordContainerView> {
  @override
  Widget build(BuildContext context) {
    return UpdateForgotPasswordContainerView(
      userId: widget.userId,
    );
  }
}
