import 'package:flutter/material.dart';

import '../../../../../../core/vendor/repository/user_repository.dart';
import '../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../vendor_ui/user/edit_profile/component/verfiy_phone/edit_phone_verify_view.dart';

class CustomEditPhoneVerifyView extends StatefulWidget {
  const CustomEditPhoneVerifyView(
      {Key? key,
      required this.userName,
      required this.phoneNumber,
      required this.phoneId,
      required this.animationController,})
      : super(key: key);

  final String userName;
  final String phoneNumber;
  final String? phoneId;
  final AnimationController? animationController;
  @override
  _EditPhoneVerifyViewState createState() => _EditPhoneVerifyViewState();
}

class _EditPhoneVerifyViewState extends State<CustomEditPhoneVerifyView> {
  UserRepository? repo1;
  PsValueHolder? valueHolder;

  @override
  Widget build(BuildContext context) {
    return EditPhoneVerifyView(
        userName: widget.userName,
        phoneNumber: widget.phoneNumber,
        phoneId: widget.phoneId,
        animationController: widget.animationController);
  }
}
