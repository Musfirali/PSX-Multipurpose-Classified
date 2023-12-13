import 'package:flutter/material.dart';

import '../../../vendor_ui/faq/view/setting_faq_view.dart';

class CustomSettingFAQView extends StatefulWidget {
  const CustomSettingFAQView();
  @override
  _SettingFAQViewState createState() {
    return _SettingFAQViewState();
  }
}

class _SettingFAQViewState extends State<CustomSettingFAQView> {
  @override
  Widget build(BuildContext context) {
    return const SettingFAQView();
  }
}
