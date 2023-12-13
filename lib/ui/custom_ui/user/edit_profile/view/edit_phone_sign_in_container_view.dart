import 'package:flutter/material.dart';

import '../../../../vendor_ui/user/edit_profile/view/edit_phone_sign_in_container_view.dart';

class CustomEditPhoneSignInContainerView extends StatefulWidget {
  const CustomEditPhoneSignInContainerView({this.phoneNum});
  final String? phoneNum;
  @override
  _EditPhoneSignInContainerViewState createState() =>
      _EditPhoneSignInContainerViewState();
}

class _EditPhoneSignInContainerViewState
    extends State<CustomEditPhoneSignInContainerView> {
  @override
  Widget build(BuildContext context) {
    return EditPhoneSignInContainerView(
      phoneNum: widget.phoneNum,
    );
  }
}
