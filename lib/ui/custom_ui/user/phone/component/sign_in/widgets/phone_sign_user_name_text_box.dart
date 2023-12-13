import 'package:flutter/material.dart';

import '../../../../../../vendor_ui/user/phone/component/sign_in/widgets/phone_sign_user_name_text_box.dart';

class CustomPhoneSignUserNameTextBox extends StatelessWidget {
  const CustomPhoneSignUserNameTextBox({
    required this.nameController,
  });

  final TextEditingController? nameController;
  @override
  Widget build(BuildContext context) {
    return PhoneSignUserNameTextBox(nameController: nameController);
  }
}
