import 'package:flutter/material.dart';

import '../../../vendor_ui/introslider/component/title.dart';

class CustomSliderTitle extends StatelessWidget {
  const CustomSliderTitle({required this.currentIndex});
  final int currentIndex;
  @override
  Widget build(BuildContext context) {
    return SliderTitle(currentIndex: currentIndex);
  }
}
