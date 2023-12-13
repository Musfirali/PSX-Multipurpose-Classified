import 'package:flutter/material.dart';

import '../../../vendor_ui/introslider/component/description.dart';

class CustomDescription extends StatelessWidget {
  const CustomDescription({required this.currentIndex});
  final int currentIndex;
  @override
  Widget build(BuildContext context) {
    return Description(currentIndex: currentIndex);
  }
}
