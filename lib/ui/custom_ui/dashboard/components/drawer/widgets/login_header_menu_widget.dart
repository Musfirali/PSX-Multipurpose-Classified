import 'package:flutter/material.dart';

import '../../../../../vendor_ui/dashboard/components/drawer/widgets/login_header_menu_widget.dart';

class CustomLoginHeaderMenuWidget extends StatelessWidget {
  const CustomLoginHeaderMenuWidget({this.updateSelectedIndexWithAnimation});
  final Function? updateSelectedIndexWithAnimation;
  @override
  Widget build(BuildContext context) {
    return LoginHeaderMenuWidget(
      updateSelectedIndexWithAnimation: updateSelectedIndexWithAnimation,
    );
  }
}
