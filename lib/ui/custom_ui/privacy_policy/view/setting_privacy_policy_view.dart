import 'package:flutter/material.dart';

import '../../../vendor_ui/privacy_policy/view/setting_privacy_policy_view.dart';

class CustomSettingPrivacyPolicyView extends StatefulWidget {
  @override
  _SettingPrivacyPolicyViewState createState() {
    return _SettingPrivacyPolicyViewState();
  }
}

class _SettingPrivacyPolicyViewState
    extends State<CustomSettingPrivacyPolicyView> {

  @override
  Widget build(BuildContext context) {
    return SettingPrivacyPolicyView();
  }
}
