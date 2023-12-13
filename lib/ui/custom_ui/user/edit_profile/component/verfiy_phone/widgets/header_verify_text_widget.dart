import 'package:flutter/material.dart';
import 'package:psxmpc/ui/vendor_ui/user/edit_profile/component/verfiy_phone/widgets/header_verify_text_widget.dart';

class CustomHeaderVerifyTextWidget extends StatelessWidget {
  const CustomHeaderVerifyTextWidget({required this.phoneNumber});

  final String phoneNumber;
  @override
  Widget build(BuildContext context) {
    return HeaderVerifyTextWidget(phoneNumber: phoneNumber);
  }
}
