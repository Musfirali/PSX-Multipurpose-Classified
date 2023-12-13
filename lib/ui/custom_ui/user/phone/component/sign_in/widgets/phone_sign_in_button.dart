import 'package:flutter/material.dart';

import '../../../../../../vendor_ui/user/phone/component/sign_in/widgets/phone_sign_in_button.dart';

class CustomPhoneSignInButton extends StatefulWidget {
  const CustomPhoneSignInButton(
      {required this.nameController,
      required this.phoneController,
      required this.phoneSignInSelected});
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final Function? phoneSignInSelected;

  @override
  __SendButtonWidgetState createState() => __SendButtonWidgetState();
}

class __SendButtonWidgetState extends State<CustomPhoneSignInButton> {
  @override
  Widget build(BuildContext context) {
    return PhoneSignInButton(
        nameController: widget.nameController,
        phoneController: widget.phoneController,
        phoneSignInSelected: widget.phoneSignInSelected);
  }
}
