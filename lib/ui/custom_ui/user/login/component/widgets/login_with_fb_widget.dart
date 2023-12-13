import 'package:flutter/material.dart';

import '../../../../../vendor_ui/user/login/component/widgets/login_with_fb_widget.dart';

class CustomLoginWithFbWidget extends StatelessWidget {
  const CustomLoginWithFbWidget(
      {required this.onFbSignInSelected,
      required this.callBackAfterLoginSuccess});

  final Function? onFbSignInSelected, callBackAfterLoginSuccess;
  @override
  Widget build(BuildContext context) {
    return LoginWithFbWidget(
      onFbSignInSelected: onFbSignInSelected,
      callBackAfterLoginSuccess: callBackAfterLoginSuccess,
    );
  }
}
