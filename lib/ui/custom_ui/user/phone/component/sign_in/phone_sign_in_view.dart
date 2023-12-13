import 'package:flutter/material.dart';

import '../../../../../vendor_ui/user/phone/component/sign_in/phone_sign_in_view.dart';

class CustomPhoneSignInView extends StatefulWidget {
  const CustomPhoneSignInView(
      {Key? key,
      this.animationController,
      this.goToLoginSelected,
      this.phoneSignInSelected})
      : super(key: key);
  final AnimationController? animationController;
  final Function? goToLoginSelected;
  final Function? phoneSignInSelected;
  @override
  _PhoneSignInViewState createState() => _PhoneSignInViewState();
}

class _PhoneSignInViewState extends State<CustomPhoneSignInView> {
  @override
  Widget build(BuildContext context) {
    return PhoneSignInView(
      animationController: widget.animationController,
      goToLoginSelected: widget.goToLoginSelected,
      phoneSignInSelected: widget.phoneSignInSelected,
    );
  }
}
