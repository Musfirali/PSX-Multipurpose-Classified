import 'package:flutter/material.dart';

import '../../../vendor_ui/introslider/view/intro_slider_view.dart';

class CustomIntroSliderView extends StatefulWidget {
  const CustomIntroSliderView({required this.fromSettingSlider});
  final bool fromSettingSlider;
  @override
  _IntroSliderViewState createState() => _IntroSliderViewState();
}

class _IntroSliderViewState extends State<CustomIntroSliderView> {
  @override
  Widget build(BuildContext context) {
    return IntroSliderView(fromSettingSlider: widget.fromSettingSlider);
  }
}
