import 'package:flutter/material.dart';
import '../../../../vendor_ui/user/profile/view/profile_view.dart';

class CustomProfileView extends StatefulWidget {
  const CustomProfileView({
    Key? key,
    required this.animationController,
    required this.flag,
    this.userId,
    required this.scaffoldKey,
    required this.callLogoutCallBack,
    required this.onDeactivate,
    required this.loadUserData,
    required this.isJustLogined, 
    required this.changeIsJustLoginToFalse
  }) : super(key: key);

  final AnimationController animationController;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final int? flag;
  final String? userId;
  final Function callLogoutCallBack, onDeactivate, loadUserData;
  final bool isJustLogined;
  final Function changeIsJustLoginToFalse;
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<CustomProfileView> {
  @override
  Widget build(BuildContext context) {
    return ProfileView(
      animationController: widget.animationController,
      flag: widget.flag,
      scaffoldKey: widget.scaffoldKey,
      callLogoutCallBack: widget.callLogoutCallBack,
      userId: widget.userId,
      onDeactivate: widget.onDeactivate,
      loadUserData: widget.loadUserData,
      isJustLogined: widget.isJustLogined,
      changeIsJustLoginToFalse: widget.changeIsJustLoginToFalse,
    );
  }
}