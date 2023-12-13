import 'package:flutter/material.dart';

import '../../../vendor_ui/setting/view/camera_setting_view.dart';

class CustomCameraSettingView extends StatefulWidget {
  @override
  _NotificationSettingViewState createState() =>
      _NotificationSettingViewState();
}

class _NotificationSettingViewState extends State<CustomCameraSettingView> {
  @override
  Widget build(BuildContext context) {
    return CameraSettingView();
  }
}
