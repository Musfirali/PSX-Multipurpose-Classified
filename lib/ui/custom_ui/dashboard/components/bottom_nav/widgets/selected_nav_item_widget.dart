import 'package:flutter/material.dart';

import '../../../../../vendor_ui/dashboard/components/bottom_nav/widgets/selected_nav_item_widget.dart';

class CustomSelectedNavItemWidget extends StatelessWidget {
  const CustomSelectedNavItemWidget({required this.icon});
  final Widget icon;
  @override
  Widget build(BuildContext context) {
    return SelectedNavItemWidget(icon: icon);
  }
}
