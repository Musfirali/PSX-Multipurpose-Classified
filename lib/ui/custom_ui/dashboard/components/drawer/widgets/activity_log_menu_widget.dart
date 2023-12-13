import 'package:flutter/material.dart';

import '../../../../../vendor_ui/dashboard/components/drawer/widgets/activity_log_menu_widget.dart';

class CustomActivityLogMenuWidget extends StatelessWidget {
  const CustomActivityLogMenuWidget({this.updateSelectedIndexWithAnimation});
  final Function? updateSelectedIndexWithAnimation;

  @override
  Widget build(BuildContext context) {
    return ActivityLogMenuWidget(
      updateSelectedIndexWithAnimation: updateSelectedIndexWithAnimation,
    );
  }
}
