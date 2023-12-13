import 'package:flutter/material.dart';

import '../../../../../vendor_ui/user/verify_email/component/widgets/email_verify_back_widget.dart';

class CustomEmailVerifyBackWidget extends StatelessWidget {
  const CustomEmailVerifyBackWidget({required this.onSignInSelected});
  final Function? onSignInSelected;
  @override
  Widget build(BuildContext context) {
    return EmailVerifyBackWidget(onSignInSelected: onSignInSelected);
  }
}
