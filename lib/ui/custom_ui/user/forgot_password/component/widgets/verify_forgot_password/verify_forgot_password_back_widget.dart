import 'package:flutter/material.dart';

import '../../../../../../vendor_ui/user/forgot_password/component/widgets/verify_forgot_password/verify_forgot_password_back_widget.dart';

class CustomVerifyForgotPasswordBackWidget extends StatelessWidget {
  const CustomVerifyForgotPasswordBackWidget({this.onToForgotPasswordSelected});

  final Function? onToForgotPasswordSelected;

  @override
  Widget build(BuildContext context) {
    return VerifyForgotPasswordBackWidget(
      onToForgotPasswordSelected: onToForgotPasswordSelected,
    );
  }
}
