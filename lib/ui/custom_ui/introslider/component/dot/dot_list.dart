import 'package:flutter/material.dart';

import '../../../../vendor_ui/introslider/component/dot/dot_list.dart';

class CustomDotList extends StatelessWidget {
  const CustomDotList({required this.orientation, required this.currentIndex});
  final Orientation orientation;
  final int currentIndex;
  @override
  Widget build(BuildContext context) {
    return DotList(
      currentIndex: currentIndex,
      orientation: orientation,
    );
  }
}
