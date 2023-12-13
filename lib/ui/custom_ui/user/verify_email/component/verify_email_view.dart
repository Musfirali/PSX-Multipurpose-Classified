import 'package:flutter/material.dart';

import '../../../../vendor_ui/user/verify_email/component/verify_email_view.dart';

class CustomVerifyEmailView extends StatefulWidget {
  const CustomVerifyEmailView(
      {Key? key,
      this.animationController,
      this.onProfileSelected,
      this.onSignInSelected,
      this.userId})
      : super(key: key);

  final AnimationController? animationController;
  final Function? onProfileSelected, onSignInSelected;
  final String? userId;
  @override
  _VerifyEmailViewState createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<CustomVerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return VerifyEmailView(
      animationController: widget.animationController,
      onProfileSelected: widget.onProfileSelected,
      onSignInSelected: widget.onSignInSelected,
      userId: widget.userId,
    );
  }
}
