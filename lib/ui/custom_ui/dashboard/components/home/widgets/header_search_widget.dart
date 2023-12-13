
import 'package:flutter/material.dart';

import '../../../../../vendor_ui/dashboard/components/home/widgets/header_search_widget.dart';

class CustomHomeSearchHeaderWidget extends StatefulWidget {
  const CustomHomeSearchHeaderWidget(
      {Key? key, required this.animationController})
      : super(key: key);

  final AnimationController? animationController;

  @override
  __HomeSearchHeaderWidgetState createState() =>
      __HomeSearchHeaderWidgetState();
}

class __HomeSearchHeaderWidgetState
    extends State<CustomHomeSearchHeaderWidget> {
  @override
  Widget build(BuildContext context) {
    return HomeSearchHeaderWidget(
        animationController: widget.animationController);
  }
}

