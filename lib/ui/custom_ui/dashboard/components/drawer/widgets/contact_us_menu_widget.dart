import 'package:flutter/material.dart';

import '../../../../../vendor_ui/dashboard/components/drawer/widgets/contact_us_menu_widget.dart';

class CustomContactUsMenuWidget extends StatelessWidget {
  const CustomContactUsMenuWidget({this.updateSelectedIndexWithAnimation});
  final Function? updateSelectedIndexWithAnimation;
  
  @override
  Widget build(BuildContext context) {
    return ContactUsMenuWidget(
      updateSelectedIndexWithAnimation: updateSelectedIndexWithAnimation,
    );
  }
}
