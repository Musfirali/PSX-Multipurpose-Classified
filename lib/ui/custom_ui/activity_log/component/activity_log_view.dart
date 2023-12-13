import 'package:flutter/material.dart';

import '../../../vendor_ui/activity_log/component/activity_log_view.dart';

class CustomActivityLogView extends StatefulWidget {
  const CustomActivityLogView(
      {Key? key, required this.scaffoldKey, required this.animationController})
      : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey;
  final AnimationController? animationController;
  @override
  _CustomActivityLogViewState createState() => _CustomActivityLogViewState();
}

class _CustomActivityLogViewState extends State<CustomActivityLogView> {
  @override
  Widget build(BuildContext context) {
    return ActivityLogView(
      scaffoldKey: widget.scaffoldKey,
      animationController: widget.animationController,
    );
  }
}
