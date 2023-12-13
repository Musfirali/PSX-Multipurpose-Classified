import 'package:flutter/material.dart';

import '../../../vendor_ui/introslider/component/slider_photo.dart';

class CustomSliderPhoto extends StatelessWidget {
  const CustomSliderPhoto(
      {required this.orientation, required this.currentIndex});
  final Orientation orientation;
  final int currentIndex;
  @override
  Widget build(BuildContext context) {
    return SliderPhoto(orientation: orientation, currentIndex: currentIndex);
  }
}
