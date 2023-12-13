import 'package:flutter/material.dart';

import '../../../../../vendor_ui/dashboard/components/drawer/widgets/user_offers_menu_widget.dart';

class CustomUserOfferMenuWidget extends StatelessWidget {
  const CustomUserOfferMenuWidget({this.updateSelectedIndexWithAnimation});
  final Function? updateSelectedIndexWithAnimation;

  @override
  Widget build(BuildContext context) {
    return UserOfferMenuWidget(
      updateSelectedIndexWithAnimation: updateSelectedIndexWithAnimation,
    );
  }
}
