import 'package:flutter/material.dart';

import '../../../vendor_ui/safety_tips/view/safety_tips_view.dart';

class CustomSafetyTipsView extends StatefulWidget {
  const CustomSafetyTipsView({
    Key? key,
    required this.safetyTips,
  }) : super(key: key);

  final String? safetyTips;
  @override
  _SafetyTipsViewState createState() => _SafetyTipsViewState();
}

class _SafetyTipsViewState extends State<CustomSafetyTipsView> {
  @override
  Widget build(BuildContext context) {
    return SafetyTipsView(safetyTips: widget.safetyTips);
  }
}
