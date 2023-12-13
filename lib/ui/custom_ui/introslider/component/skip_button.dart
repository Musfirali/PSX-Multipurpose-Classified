import 'package:flutter/material.dart';

import '../../../vendor_ui/introslider/component/skip_button.dart';

class CustomSkipButton extends StatelessWidget {
  const CustomSkipButton({
    required this.fromSettingSlider
  });
  final bool fromSettingSlider;
  @override
  Widget build(BuildContext context) {
    return SkipButton(
      fromSettingSlider: fromSettingSlider,
    );
  }
}
