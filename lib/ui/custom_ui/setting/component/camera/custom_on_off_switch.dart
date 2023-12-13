import 'package:flutter/material.dart';

import '../../../../vendor_ui/setting/component/camera/custom_on_off_switch.dart';

class CustomCustomCameraOnOffSwitch extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CustomCameraOnOffSwitchState();
}

class _CustomCameraOnOffSwitchState
    extends State<CustomCustomCameraOnOffSwitch> {
  @override
  Widget build(BuildContext context) {
    return CustomCameraOnOffSwitch();
  }
}
