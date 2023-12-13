import 'package:flutter/material.dart';

import '../../../../../../vendor_ui/user/forgot_password/component/widgets/update_forgot_password/update_forgot_pwd_back_widget.dart';

class CustomUpdateForgotPasswordBackWidget extends StatelessWidget {
  const CustomUpdateForgotPasswordBackWidget({
      this.goToVerifyPasswordSelected});

  final Function? goToVerifyPasswordSelected;

  @override
  Widget build(BuildContext context) {
    return UpdateForgotPasswordBackWidget(
      goToVerifyPasswordSelected: goToVerifyPasswordSelected,
    );
  }
}
