import 'package:flutter/material.dart';

import '../../../vendor_ui/introslider/component/explore_button.dart';

class CustomExploreButton extends StatelessWidget {
  const CustomExploreButton({required this.fromSettingSlider});
  final bool fromSettingSlider;
  @override
  Widget build(BuildContext context) {
    return ExploreButton(fromSettingSlider: fromSettingSlider);
  }
}
