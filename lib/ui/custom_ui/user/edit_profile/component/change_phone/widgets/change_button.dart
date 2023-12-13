import 'package:flutter/material.dart';

import '../../../../../../vendor_ui/user/edit_profile/component/change_phone/widgets/change_button.dart';

class CustomChangeButton extends StatefulWidget {
  const CustomChangeButton(
      {required this.phoneController,
      required this.countryCodeController,});
  final TextEditingController phoneController;
  final TextEditingController countryCodeController;

  @override
  __SendButtonWidgetState createState() => __SendButtonWidgetState();
}

class __SendButtonWidgetState extends State<CustomChangeButton> {
  @override
  Widget build(BuildContext context) {
    return ChangeButton(
        phoneController: widget.phoneController,
        countryCodeController: widget.countryCodeController,);
  }
}