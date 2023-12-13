import 'package:flutter/material.dart';

import '../../../../vendor_ui/user/register/view/register_container_view.dart';

class CustomRegisterContainerView extends StatefulWidget {
  @override
  _CityRegisterContainerViewState createState() =>
      _CityRegisterContainerViewState();
}

class _CityRegisterContainerViewState
    extends State<CustomRegisterContainerView> {
  @override
  Widget build(BuildContext context) {
    return RegisterContainerView();
  }
}
