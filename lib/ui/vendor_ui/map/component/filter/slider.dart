import 'package:flutter/material.dart';


class KMSlider extends StatelessWidget {
  const KMSlider(
      {required this.value, required this.onChanged, required this.label});
  final double value;
  final Function onChanged;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Slider(
      activeColor: Theme.of(context).primaryColor,
      value: value,
      onChanged: (double value) {
        onChanged(value);
      },
      divisions: 10,
      label: label,
    );
  }
}
