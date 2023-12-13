import 'package:flutter/material.dart';

import '../../../../../vendor_ui/user/login/component/widgets/login_with_apple_widget.dart';

class CustomLoginWithAppleIdWidget extends StatelessWidget {
  const CustomLoginWithAppleIdWidget(
      {required this.onAppleIdSignInSelected,
      required this.callBackAfterLoginSuccess});

  final Function? onAppleIdSignInSelected, callBackAfterLoginSuccess;

  @override
  Widget build(BuildContext context) {
    return LoginWithAppleIdWidget(
      onAppleIdSignInSelected: onAppleIdSignInSelected,
      callBackAfterLoginSuccess: callBackAfterLoginSuccess,
    );
  }
}
