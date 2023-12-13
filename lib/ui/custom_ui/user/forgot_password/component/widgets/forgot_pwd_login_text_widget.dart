import 'package:flutter/material.dart';

import '../../../../../vendor_ui/user/forgot_password/component/widgets/forgot_pwd_login_text_widget.dart';

class CustomForgotPwdLoginTextWidget extends StatelessWidget {
  const CustomForgotPwdLoginTextWidget({this.goToLoginSelected});
  final Function? goToLoginSelected;
  @override
  Widget build(BuildContext context) {
    return ForgotPwdLoginTextWidget(
      goToLoginSelected: goToLoginSelected,
    );
  }
}
