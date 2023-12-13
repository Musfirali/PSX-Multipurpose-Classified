import 'package:flutter/material.dart';

import '../../../../vendor_ui/user/register/component/register_view.dart';

class CustomRegisterView extends StatefulWidget {
  const CustomRegisterView(
      {Key? key,
      this.animationController,
      this.onRegisterSelected,
      this.goToLoginSelected})
      : super(key: key);
  final AnimationController? animationController;
  final Function? onRegisterSelected, goToLoginSelected;
  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<CustomRegisterView> {
  @override
  Widget build(BuildContext context) {
    return RegisterView(
      animationController: widget.animationController,
      goToLoginSelected: widget.goToLoginSelected,
      onRegisterSelected: widget.onRegisterSelected,
    );
  }
}
