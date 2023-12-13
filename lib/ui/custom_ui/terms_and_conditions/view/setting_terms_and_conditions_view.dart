import 'package:flutter/material.dart';

import '../../../vendor_ui/terms_and_conditions/view/setting_terms_and_conditions_view.dart';

class CustomSettingTermsAndCondition extends StatefulWidget {
  const CustomSettingTermsAndCondition();
  @override
  _SettingTermsAndConditionState createState() {
    return _SettingTermsAndConditionState();
  }
}

class _SettingTermsAndConditionState
    extends State<CustomSettingTermsAndCondition> {
  @override
  Widget build(BuildContext context) {
    return const SettingTermsAndCondition();
  }
}
