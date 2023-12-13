import 'package:flutter/material.dart';

import '../../../../../vendor_ui/user/register/component/widgets/register_name_text_box.dart';

class CustomRegisterNameTextBox extends StatelessWidget {
  const CustomRegisterNameTextBox({
    required this.nameController,
  });

  final TextEditingController? nameController;
  @override
  Widget build(BuildContext context) {
    return RegisterNameTextBox(nameController: nameController);
  }
}
