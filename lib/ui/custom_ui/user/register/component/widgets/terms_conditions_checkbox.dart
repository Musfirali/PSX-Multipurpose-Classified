import 'package:flutter/material.dart';

import '../../../../../vendor_ui/user/register/component/widgets/terms_conditions_checkbox.dart';

class CustomTermsAndConCheckbox extends StatefulWidget {
  const CustomTermsAndConCheckbox({
    required this.nameTextEditingController,
    required this.emailTextEditingController,
    required this.passwordTextEditingController,
  });

  final TextEditingController? nameTextEditingController,
      emailTextEditingController,
      passwordTextEditingController;

  @override
  __TermsAndConCheckboxState createState() => __TermsAndConCheckboxState();
}

class __TermsAndConCheckboxState extends State<CustomTermsAndConCheckbox> {
  
  @override
  Widget build(BuildContext context) {
    return TermsAndConCheckbox(
        emailTextEditingController: widget.emailTextEditingController,
        nameTextEditingController: widget.nameTextEditingController,
        passwordTextEditingController: widget.passwordTextEditingController);
  }
}
