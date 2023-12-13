
import 'package:flutter/material.dart';

import '../../../vendor_ui/dashboard/view/dashboard_view.dart';

class CustomDashboardView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<CustomDashboardView> {
  @override
  Widget build(BuildContext context) {
    return DashboardView();
  }
}
