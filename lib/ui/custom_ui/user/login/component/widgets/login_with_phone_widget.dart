import 'package:flutter/material.dart';

import '../../../../../vendor_ui/user/login/component/widgets/login_with_phone_widget.dart';

class CustomLoginWithPhoneWidget extends StatefulWidget {
  const CustomLoginWithPhoneWidget({required this.onPhoneSignInSelected});
  final Function? onPhoneSignInSelected;

  @override
  __LoginWithPhoneWidgetState createState() => __LoginWithPhoneWidgetState();
}

class __LoginWithPhoneWidgetState extends State<CustomLoginWithPhoneWidget> {
  @override
  Widget build(BuildContext context) {
    return LoginWithPhoneWidget(
        onPhoneSignInSelected: widget.onPhoneSignInSelected);
  }
}
