import 'package:flutter/material.dart';

import '../../../../vendor_ui/user/login/component/login_view.dart';

class CustomLoginView extends StatefulWidget {
  const CustomLoginView({
    Key? key,
    this.animationController,
    this.animation,
    this.onProfileSelected,
    this.onForgotPasswordSelected,
    this.onSignInSelected,
    this.onPhoneSignInSelected,
    this.onFbSignInSelected,
    this.onGoogleSignInSelected,
  }) : super(key: key);

  final AnimationController? animationController;
  final Animation<double>? animation;
  final Function? onProfileSelected,
      onForgotPasswordSelected,
      onSignInSelected,
      onPhoneSignInSelected,
      onFbSignInSelected,
      onGoogleSignInSelected;
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<CustomLoginView> {
  @override
  Widget build(BuildContext context) {
    return LoginView(
      animation: widget.animation,
      animationController: widget.animationController,
      onFbSignInSelected: widget.onFbSignInSelected,
      onForgotPasswordSelected: widget.onForgotPasswordSelected,
      onGoogleSignInSelected: widget.onGoogleSignInSelected,
      onPhoneSignInSelected: widget.onPhoneSignInSelected,
      onProfileSelected: widget.onProfileSelected,
      onSignInSelected: widget.onSignInSelected,
    );
  }
}
