import 'package:flutter/material.dart';

import '../../../../vendor_ui/dashboard/components/app_bar/appbar.dart';

class CustomDashboardAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomDashboardAppBar(
      {required this.appBarTitle, required this.appBarTitleName, required this.currentIndex,});
  final String appBarTitle;
  final String appBarTitleName;
  final int? currentIndex;

  @override
  Widget build(BuildContext context) {
    return DashboardAppBar(appBarTitle: appBarTitle, appBarTitleName: appBarTitleName, currentIndex: currentIndex,);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
