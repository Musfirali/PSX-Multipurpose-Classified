import 'package:flutter/material.dart';

import '../../../../../vendor_ui/user/edit_profile/component/change_phone/change_phone_view.dart';

class CustomEditPhoneSignInView extends StatefulWidget {
  const CustomEditPhoneSignInView(
      {Key? key,
      this.animationController,
      required this.phoneNum})
      : super(key: key);
  final AnimationController? animationController;
  final String phoneNum;
  
  @override
  _EditPhoneSignInViewState createState() => _EditPhoneSignInViewState();
}

class _EditPhoneSignInViewState extends State<CustomEditPhoneSignInView> {
  @override
  Widget build(BuildContext context) {
    return EditPhoneSignInView(
      animationController: widget.animationController,
      phoneNum: widget.phoneNum,
    );
  }
}
