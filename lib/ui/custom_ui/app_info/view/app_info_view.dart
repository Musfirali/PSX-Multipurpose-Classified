import 'package:flutter/material.dart';
import '../../../vendor_ui/app_info/view/app_info_view.dart';

class CustomAppInfoView extends StatefulWidget {
  @override
  _CustomAppInfoViewState createState() {
    return _CustomAppInfoViewState();
  }
}

class _CustomAppInfoViewState extends State<CustomAppInfoView>
    with SingleTickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return AppInfoView();
  }
}



