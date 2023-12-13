import 'package:flutter/material.dart';

import '../../../vendor_ui/contact/component/contact_us_view.dart';

class CustomContactUsView extends StatefulWidget {
  const CustomContactUsView({Key? key, required this.animationController})
      : super(key: key);
  final AnimationController? animationController;
  @override
  _ContactUsViewState createState() => _ContactUsViewState();
}

class _ContactUsViewState extends State<CustomContactUsView> {
  @override
  Widget build(BuildContext context) {
    return ContactUsView(animationController: widget.animationController);
  }
}
