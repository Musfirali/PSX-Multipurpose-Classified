import 'package:flutter/material.dart';

import '../../../../vendor_ui/terms_and_conditions/component/agree/agree_terms_and_conditions_widget.dart';

class CustomAgreeTermsAndConditionWidget extends StatefulWidget {
  @override
  _CustomAgreeTermsAndConditionWidgetState createState() {
    return _CustomAgreeTermsAndConditionWidgetState();
  }
}

class _CustomAgreeTermsAndConditionWidgetState
    extends State<CustomAgreeTermsAndConditionWidget> {
  @override
  Widget build(BuildContext context) {
    return AgreeTermsAndConditionWidget();
  }
}
