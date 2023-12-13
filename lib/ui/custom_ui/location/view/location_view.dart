import 'package:flutter/material.dart';

import '../../../vendor_ui/location/view/location_view.dart';

class CustomItemLocationView extends StatefulWidget {
  @override
  _ItemLocationViewState createState() => _ItemLocationViewState();
}

class _ItemLocationViewState extends State<CustomItemLocationView> {
  @override
  Widget build(BuildContext context) {
    return ItemLocationView();
  }
}
