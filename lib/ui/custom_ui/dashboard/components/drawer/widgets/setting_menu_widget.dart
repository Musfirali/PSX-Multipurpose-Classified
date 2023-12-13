import 'package:flutter/material.dart';

import '../../../../../vendor_ui/dashboard/components/drawer/widgets/setting_menu_widget.dart';

class CustomSettingMenuWidget extends StatelessWidget {
  const CustomSettingMenuWidget({this.updateSelectedIndexWithAnimation});
  final Function? updateSelectedIndexWithAnimation;
  
  @override
  Widget build(BuildContext context) {
    return SettingMenuWidget(
      updateSelectedIndexWithAnimation: updateSelectedIndexWithAnimation,
    );
  }
}
