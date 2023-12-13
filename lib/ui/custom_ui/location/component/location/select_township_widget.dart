import 'package:flutter/material.dart';

import '../../../../vendor_ui/location/component/location/select_township_widget.dart';

class CustomSelectTownshipWidget extends StatelessWidget {
  const CustomSelectTownshipWidget(
      {required this.searchTownshipNameController});
  final TextEditingController searchTownshipNameController;

  @override
  Widget build(BuildContext context) {
    return SelectTownshipWidget(
        searchTownshipNameController: searchTownshipNameController);
  }
}
