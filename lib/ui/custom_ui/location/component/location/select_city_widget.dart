import 'package:flutter/material.dart';

import '../../../../vendor_ui/location/component/location/select_city_widget.dart';

class CustomSelectCityWidget extends StatelessWidget {
  const CustomSelectCityWidget(
      {required this.searchCityNameController,
      required this.searchTownshipNameController});

  final TextEditingController searchCityNameController;
  final TextEditingController searchTownshipNameController;

  @override
  Widget build(BuildContext context) {
    return SelectCityWidget(
        searchCityNameController: searchCityNameController,
        searchTownshipNameController: searchTownshipNameController);
  }
}
