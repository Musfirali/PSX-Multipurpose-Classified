import 'package:flutter/material.dart';

import '../../../../../../vendor_ui/user/phone/component/verify_phone/widgets/verification_in_verify_phone_widget.dart';

class CustomVerificationInPhoneVerifyWidget extends StatefulWidget {
  const CustomVerificationInPhoneVerifyWidget({
    required this.userName,
    required this.phoneNumber,
    required this.phoneId,
    required this.onSignInSelected,
    this.onProfileSelected,
  });

  final String? userName;
  final String? phoneNumber;
  final String phoneId;
  final Function? onSignInSelected;
  final Function? onProfileSelected;

  @override
  __TextFieldAndButtonWidgetState createState() =>
      __TextFieldAndButtonWidgetState();
}

class __TextFieldAndButtonWidgetState
    extends State<CustomVerificationInPhoneVerifyWidget> {
  @override
  Widget build(BuildContext context) {
    return VerificationInPhoneVerifyWidget(
      phoneId: widget.phoneId,
      phoneNumber: widget.phoneNumber,
      userName: widget.userName,
      onSignInSelected: widget.onSignInSelected,
      onProfileSelected: widget.onProfileSelected,
    );
  }
}
