import 'package:flutter/material.dart';

import '../../../../vendor_ui/map/component/filter/slider.dart';

class CustomKMSlider extends StatelessWidget {
  const CustomKMSlider(
      {required this.value, required this.onChanged, required this.label});
  final double value;
  final Function onChanged;
  final String label;

  @override
  Widget build(BuildContext context) {
    return KMSlider(value: value, onChanged: onChanged, label: label);
  }
}
