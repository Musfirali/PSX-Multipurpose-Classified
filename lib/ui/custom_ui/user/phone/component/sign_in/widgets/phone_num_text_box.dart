import 'package:flutter/material.dart';

import '../../../../../../vendor_ui/user/phone/component/sign_in/widgets/phone_num_text_box.dart';

class CustomPhoneNumTextBox extends StatelessWidget {
  const CustomPhoneNumTextBox({
    required this.phoneController,
    });

  final TextEditingController phoneController;
  
  @override
  Widget build(BuildContext context) {
    return PhoneNumTextBox(
      phoneController: phoneController,
    );
  }
}
