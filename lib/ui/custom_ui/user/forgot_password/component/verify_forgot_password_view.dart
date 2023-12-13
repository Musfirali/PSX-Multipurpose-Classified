import 'package:flutter/material.dart';

import '../../../../../core/vendor/repository/user_repository.dart';
import '../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../vendor_ui/user/forgot_password/component/verify_forgot_password_view.dart';

class CustomVerifyForgotPasswordView extends StatefulWidget {
  const CustomVerifyForgotPasswordView(
      {Key? key,
      this.animationController,
      this.userEmail,
      this.onToForgotPasswordSelected,
      this.onUpdateForgotChangeSelected})
      : super(key: key);

  final AnimationController? animationController;
  final String? userEmail;
  final Function? onToForgotPasswordSelected;
  final Function? onUpdateForgotChangeSelected;

  @override
  _VerifyForgotPasswordViewState createState() =>
      _VerifyForgotPasswordViewState();
}

class _VerifyForgotPasswordViewState extends State<CustomVerifyForgotPasswordView> {
  UserRepository? repo1;
  PsValueHolder? valueHolder;

  @override
  Widget build(BuildContext context) {
    return VerifyForgotPasswordView(
      animationController: widget.animationController,
      onToForgotPasswordSelected: widget.onToForgotPasswordSelected,
      onUpdateForgotChangeSelected: widget.onUpdateForgotChangeSelected,
      userEmail: widget.userEmail,
    );
  }
}
