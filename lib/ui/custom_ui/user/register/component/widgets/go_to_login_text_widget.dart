import 'package:flutter/material.dart';

import '../../../../../vendor_ui/user/register/component/widgets/go_to_login_text_widget.dart';

class CustomGoToLoginTextWidget extends StatelessWidget {
  const CustomGoToLoginTextWidget({Key? key, this.onSignInSelected})
      : super(key: key);

  final Function? onSignInSelected;

  @override
  Widget build(BuildContext context) {
    return GoToLoginTextWidget(onSignInSelected: onSignInSelected);
  }
}
