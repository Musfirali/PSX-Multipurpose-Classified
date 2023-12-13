import 'package:flutter/material.dart';

import '../../../../../vendor_ui/user/edit_profile/component/profile/phone_no_widget.dart';

class CustomPhoneNoWidget extends StatelessWidget {
  const CustomPhoneNoWidget({required this.phoneController});
  final TextEditingController phoneController;

  @override
  Widget build(BuildContext context) {
    return PhoneNoWidget(phoneController: phoneController);
  }
}
