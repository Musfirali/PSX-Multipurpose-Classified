import 'package:flutter/material.dart';

import '../../../vendor_ui/setting/view/setting_container_view.dart';

class CustomSettingContainerView extends StatefulWidget {
  @override
  _SettingContainerViewState createState() => _SettingContainerViewState();
}

class _SettingContainerViewState extends State<CustomSettingContainerView> {
  @override
  Widget build(BuildContext context) {
    return SettingContainerView();
  }
}
