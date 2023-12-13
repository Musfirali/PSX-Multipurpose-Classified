import 'package:flutter/material.dart';

import '../../../../vendor_ui/user/login/view/login_container_view.dart';

class CustomLoginContainerView extends StatefulWidget {
  const CustomLoginContainerView();
  
  @override
  _CityLoginContainerViewState createState() => _CityLoginContainerViewState();
}

class _CityLoginContainerViewState extends State<CustomLoginContainerView> {
  @override
  Widget build(BuildContext context) {
    return const LoginContainerView();
  }
}
