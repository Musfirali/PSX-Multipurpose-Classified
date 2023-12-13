import 'package:flutter/material.dart';

import '../../../../vendor_ui/dashboard/components/home/home_dashboard_view.dart';

class CustomHomeDashboardViewWidget extends StatefulWidget {
  const CustomHomeDashboardViewWidget(
    this.animationController,
    this.context,
  );

  final AnimationController animationController;
  final BuildContext context;

  @override
  _HomeDashboardViewWidgetState createState() =>
      _HomeDashboardViewWidgetState();
}

class _HomeDashboardViewWidgetState
    extends State<CustomHomeDashboardViewWidget> {
  @override
  Widget build(BuildContext context) {
    return HomeDashboardViewWidget(
        widget.animationController, context);
  }
}
