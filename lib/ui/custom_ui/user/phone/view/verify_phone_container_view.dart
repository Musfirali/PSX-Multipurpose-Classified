import 'package:flutter/material.dart';

import '../../../../vendor_ui/user/phone/view/verify_phone_container_view.dart';

class CustomVerifyPhoneContainerView extends StatefulWidget {
  const CustomVerifyPhoneContainerView({
    Key? key,
    required this.userName,
    required this.phoneNumber,
    required this.phoneId,
  }) : super(key: key);
  final String userName;
  final String phoneNumber;
  final String phoneId;
  @override
  _CityVerifyPhoneContainerViewState createState() =>
      _CityVerifyPhoneContainerViewState();
}

class _CityVerifyPhoneContainerViewState
    extends State<CustomVerifyPhoneContainerView> {
  @override
  Widget build(BuildContext context) {
    return VerifyPhoneContainerView(
        userName: widget.userName,
        phoneNumber: widget.phoneNumber,
        phoneId: widget.phoneId);
  }
}
