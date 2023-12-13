import 'package:flutter/material.dart';

import '../../../../vendor_ui/user/edit_profile/view/edit_phone_verify_container_view.dart';

class CustomEditPhoneVerifyContainerView extends StatefulWidget {
  const CustomEditPhoneVerifyContainerView(
      {Key? key,
      required this.userName,
      required this.phoneNumber,
      required this.phoneId})
      : super(key: key);
  final String userName;
  final String phoneNumber;
  final String? phoneId;
  @override
  _EditPhoneVerifyContainerViewState createState() =>
      _EditPhoneVerifyContainerViewState();
}

class _EditPhoneVerifyContainerViewState
    extends State<CustomEditPhoneVerifyContainerView> {
  @override
  Widget build(BuildContext context) {
    return EditPhoneVerifyContainerView(
      phoneId: widget.phoneId,
      phoneNumber: widget.phoneNumber,
      userName: widget.userName,
    );
  }
}
