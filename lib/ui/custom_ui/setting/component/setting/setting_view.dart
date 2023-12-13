import 'package:flutter/material.dart';

import '../../../../vendor_ui/setting/component/setting/setting_view.dart';

class CustomSettingView extends StatefulWidget {
  const CustomSettingView({Key? key, required this.animationController})
      : super(key: key);
  final AnimationController? animationController;
  @override
  _SettingViewState createState() => _SettingViewState();
}

class _SettingViewState extends State<CustomSettingView> {
  @override
  Widget build(BuildContext context) {
    return SettingView(animationController: widget.animationController);
  }
}
