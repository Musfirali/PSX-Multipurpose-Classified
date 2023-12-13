import 'package:flutter/material.dart';

import '../../../../../core/vendor/provider/delete_task/delete_task_provider.dart';
import '../../../../vendor_ui/dashboard/components/drawer/drawer_widgets_list.dart';

class CustomDrawerWidgetList extends StatefulWidget {
  const CustomDrawerWidgetList(
      {required this.updateSelectedIndexWithAnimation,
      required this.callLogout,
      required this.deleteTaskProvider,
      required this.scaffoldKey});
  final Function updateSelectedIndexWithAnimation;
  final Function callLogout;
  final DeleteTaskProvider deleteTaskProvider;
  final GlobalKey<ScaffoldState> scaffoldKey;
  @override
  DrawerWidgetState createState() =>
      DrawerWidgetState();
}

class DrawerWidgetState
    extends State<CustomDrawerWidgetList> {
  @override
  Widget build(BuildContext context) {
    return DrawerWidgetList(
        updateSelectedIndexWithAnimation:
            widget.updateSelectedIndexWithAnimation,
        callLogout: widget.callLogout,
        deleteTaskProvider: widget.deleteTaskProvider,
        scaffoldKey: widget.scaffoldKey);
  }
}
