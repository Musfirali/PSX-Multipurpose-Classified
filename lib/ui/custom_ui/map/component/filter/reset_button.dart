import 'package:flutter/material.dart';

import '../../../../vendor_ui/map/component/filter/reset_button.dart';

class CustomResetButton extends StatelessWidget {
  const CustomResetButton({required this.resetCallBack});
  final Function resetCallBack;
  @override
  Widget build(BuildContext context) {
    return ResetButton(resetCallBack: resetCallBack);
  }
}
