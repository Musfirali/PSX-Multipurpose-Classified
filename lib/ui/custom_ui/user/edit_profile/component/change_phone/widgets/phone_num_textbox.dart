import 'package:flutter/material.dart';

import '../../../../../../vendor_ui/user/edit_profile/component/change_phone/widgets/phone_num_textbox.dart';

class CustomPhoneNumberTextBox extends StatelessWidget {
  const CustomPhoneNumberTextBox(
      {required this.phoneController,
      required this.countryCodeController,
      required this.phoneNum});

  final TextEditingController phoneController;
  final TextEditingController countryCodeController;
  final String phoneNum;
  @override
  Widget build(BuildContext context) {
    return PhoneNumberTextBox(
        phoneController: phoneController,
        countryCodeController: countryCodeController,
        phoneNum: phoneNum);
  }
}
