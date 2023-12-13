import 'package:flutter/material.dart';

import '../../../../../vendor_ui/user/register/component/widgets/terms_and_conditions_text.dart';

class CustomTermsAndConditionTextWidget extends StatelessWidget {
  const CustomTermsAndConditionTextWidget({
    Key? key,
    required this.nameTextEditingController,
    required this.emailTextEditingController,
    required this.passwordTextEditingController,
  }) : super(key: key);

  final TextEditingController? nameTextEditingController,
      emailTextEditingController,
      passwordTextEditingController;

  @override
  Widget build(BuildContext context) {
    return TermsAndConditionTextWidget(
      nameTextEditingController: nameTextEditingController,
      emailTextEditingController: emailTextEditingController,
      passwordTextEditingController: passwordTextEditingController,
    );
  }
}
