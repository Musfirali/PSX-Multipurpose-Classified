import 'package:flutter/material.dart';

import '../../../../../vendor_ui/setting/component/setting/widgets/setting_dark_white_mode.dart';

class CustomSettingDarkAndWhiteModeWidget extends StatefulWidget {
  const CustomSettingDarkAndWhiteModeWidget(
      {Key? key, this.animationController})
      : super(key: key);
  final AnimationController? animationController;
  @override
  __SettingDarkAndWhiteModeWidgetState createState() =>
      __SettingDarkAndWhiteModeWidgetState();
}

class __SettingDarkAndWhiteModeWidgetState
    extends State<CustomSettingDarkAndWhiteModeWidget> {
  bool checkClick = false;
  bool isDarkOrWhite = false;
  @override
  Widget build(BuildContext context) {
    return SettingDarkAndWhiteModeWidget(
      animationController: widget.animationController,
    );
  }
}
