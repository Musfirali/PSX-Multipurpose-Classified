import 'package:flutter/material.dart';

import '../../../../../vendor_ui/user/profile/component/detail_info/profile_detail_widget.dart';

class CustomProfileDetailWidget extends StatefulWidget {
  const CustomProfileDetailWidget(
      {Key? key,
      required this.animationController,
      required this.callLogoutCallBack})
      : super(key: key);

  final AnimationController? animationController;
  final Function callLogoutCallBack;

  @override
  __ProfileDetailWidgetState createState() => __ProfileDetailWidgetState();
}

class __ProfileDetailWidgetState extends State<CustomProfileDetailWidget> {
  @override
  Widget build(BuildContext context) {
    return ProfileDetailWidget(
      animationController: widget.animationController,
      callLogoutCallBack: widget.callLogoutCallBack,
    );
  }
}
