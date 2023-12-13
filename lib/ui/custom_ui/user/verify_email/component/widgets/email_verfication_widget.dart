import 'package:flutter/material.dart';

import '../../../../../vendor_ui/user/verify_email/component/widgets/email_verfication_widget.dart';

class CustomEmailVerificationWidget extends StatefulWidget {
  const CustomEmailVerificationWidget({
    this.onProfileSelected,
    required this.userId,
  });

  final Function? onProfileSelected;
  final String? userId;

  @override
  __TextFieldAndButtonWidgetState createState() =>
      __TextFieldAndButtonWidgetState();
}

class __TextFieldAndButtonWidgetState
    extends State<CustomEmailVerificationWidget> {
  @override
  Widget build(BuildContext context) {
    return EmailVerificationWidget(
        userId: widget.userId, onProfileSelected: widget.onProfileSelected);
  }
}
