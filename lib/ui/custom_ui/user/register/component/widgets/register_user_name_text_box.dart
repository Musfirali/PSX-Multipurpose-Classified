import 'package:flutter/material.dart';
import 'package:psxmpc/ui/vendor_ui/user/register/component/widgets/register_user_name_text_box.dart';


class CustomRegisterUserNameTextBox extends StatelessWidget {
  const CustomRegisterUserNameTextBox({
    required this.userNameController,
  });

  final TextEditingController? userNameController;
  @override
  Widget build(BuildContext context) {
    return RegisterUserNameTextBox(userNameController: userNameController);
  }
}
