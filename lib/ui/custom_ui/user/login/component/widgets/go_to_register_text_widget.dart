import 'package:flutter/material.dart';

import '../../../../../vendor_ui/user/login/component/widgets/go_to_register_text_widget.dart';

class CustomGoToRegisterTextWidget extends StatelessWidget {
  const CustomGoToRegisterTextWidget({Key? key, this.onSignInSelected})
      : super(key: key);

  final Function? onSignInSelected;

  @override
  Widget build(BuildContext context) {
    return GoToRegisterTextWidget(
      onSignInSelected: onSignInSelected,
    );
  }
}
