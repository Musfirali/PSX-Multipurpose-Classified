import 'package:flutter/material.dart';

import '../../../../vendor_ui/user/verify_email/view/verify_email_container_view.dart';


class CustomVerifyEmailContainerView extends StatefulWidget {
  const CustomVerifyEmailContainerView({required this.userId});
  final String userId;
  @override
  _CityVerifyEmailContainerViewState createState() =>
      _CityVerifyEmailContainerViewState();
}

class _CityVerifyEmailContainerViewState
    extends State<CustomVerifyEmailContainerView> {
  @override
  Widget build(BuildContext context) {
    return VerifyEmailContainerView(
      userId: widget.userId,
    );
  }
}
