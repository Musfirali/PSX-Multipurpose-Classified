import 'package:flutter/material.dart';

import '../../../../vendor_ui/dashboard/components/bottom_nav/bottom_navigation_bar.dart';

class CustomBottomNaviationWidget extends StatefulWidget {
  const CustomBottomNaviationWidget(
      {required this.currentIndex,
      required this.updateSelectedIndexWithAnimation});
  final int? currentIndex;
  final Function updateSelectedIndexWithAnimation;
  @override
  BottomNavigationWidgetState createState() => BottomNavigationWidgetState();
}

class BottomNavigationWidgetState extends State<CustomBottomNaviationWidget> {
  @override
  Widget build(BuildContext context) {
    return BottomNaviationWidget(
      currentIndex: widget.currentIndex,
      updateSelectedIndexWithAnimation: widget.updateSelectedIndexWithAnimation,
    );
  }
}
