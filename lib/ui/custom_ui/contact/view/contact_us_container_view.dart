import 'package:flutter/material.dart';

import '../../../vendor_ui/contact/view/contact_us_container_view.dart';

class CustomContactUsContainerView extends StatefulWidget {
  @override
  _ContactUsContainerViewState createState() => _ContactUsContainerViewState();
}

class _ContactUsContainerViewState extends State<CustomContactUsContainerView> {
  @override
  Widget build(BuildContext context) {
    return ContactUsContainerView();
  }
}
