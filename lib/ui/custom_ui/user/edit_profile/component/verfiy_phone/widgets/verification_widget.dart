import 'package:flutter/material.dart';

import '../../../../../../vendor_ui/user/edit_profile/component/verfiy_phone/widgets/verification_widget.dart';

class CustomVerificationWidget extends StatefulWidget {
  const CustomVerificationWidget({
    required this.phoneNumber,
    required this.phoneId,
  });

  final String phoneNumber;
  final String? phoneId;

  @override
  __TextFieldAndButtonWidgetState createState() =>
      __TextFieldAndButtonWidgetState();
}

class __TextFieldAndButtonWidgetState extends State<CustomVerificationWidget> {
  @override
  Widget build(BuildContext context) {
    return VerificationWidget(
        phoneNumber: widget.phoneNumber, phoneId: widget.phoneId);
  }
}
