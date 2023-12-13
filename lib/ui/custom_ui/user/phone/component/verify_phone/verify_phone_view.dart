import 'package:flutter/material.dart';

import '../../../../../vendor_ui/user/phone/component/verify_phone/verify_phone_view.dart';

class CustomVerifyPhoneView extends StatefulWidget {
  const CustomVerifyPhoneView(
      {Key? key,
      required this.userName,
      required this.phoneNumber,
      required this.phoneId,
      required this.animationController,
      this.onProfileSelected,
      this.onSignInSelected})
      : super(key: key);

  final String? userName;
  final String? phoneNumber;
  final String phoneId;
  final AnimationController? animationController;
  final Function? onProfileSelected, onSignInSelected;
  @override
  _VerifyPhoneViewState createState() => _VerifyPhoneViewState();
}

class _VerifyPhoneViewState extends State<CustomVerifyPhoneView> {

  @override
  Widget build(BuildContext context) {
    return VerifyPhoneView(
      animationController: widget.animationController,
      phoneId: widget.phoneId,
      phoneNumber: widget.phoneNumber,
      userName: widget.userName,
      onProfileSelected: widget.onProfileSelected,
      onSignInSelected: widget.onSignInSelected,
    );
  }
}
