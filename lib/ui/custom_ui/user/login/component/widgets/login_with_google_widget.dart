import 'package:flutter/material.dart';

import '../../../../../vendor_ui/user/login/component/widgets/login_with_google_widget.dart';

class CustomLoginWithGoogleWidget extends StatelessWidget {
  const CustomLoginWithGoogleWidget(
      {required this.onGoogleSignInSelected,
      required this.callBackAfterLoginSuccess});

  final Function? onGoogleSignInSelected, callBackAfterLoginSuccess;

  @override
  Widget build(BuildContext context) {
    return LoginWithGoogleWidget(
      onGoogleSignInSelected: onGoogleSignInSelected,
      callBackAfterLoginSuccess: callBackAfterLoginSuccess,
    );
  }
}
