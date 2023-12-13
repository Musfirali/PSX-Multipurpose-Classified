import 'package:flutter/material.dart';

import '../../../../../../vendor_ui/user/phone/component/sign_in/widgets/back_to_login_widget.dart';

class CustomBackToLoginWidget extends StatefulWidget {
  const CustomBackToLoginWidget({this.goToLoginSelected});
  final Function? goToLoginSelected;
  @override
  __TextWidgetState createState() => __TextWidgetState();
}

class __TextWidgetState extends State<CustomBackToLoginWidget> {
  @override
  Widget build(BuildContext context) {
    return BackToLoginWidget(
      goToLoginSelected: widget.goToLoginSelected,
    );
  }
}
