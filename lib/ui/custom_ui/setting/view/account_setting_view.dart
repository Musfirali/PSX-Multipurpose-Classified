import 'package:flutter/material.dart';

import '../../../vendor_ui/setting/view/account_setting_view.dart';

class CustomAccountSettingView extends StatefulWidget {
  @override
  _NotificationSettingViewState createState() =>
      _NotificationSettingViewState();
}

class _NotificationSettingViewState extends State<CustomAccountSettingView>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return AccountSettingView();
  }
}
