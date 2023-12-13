import 'package:flutter/material.dart';

import '../../../../vendor_ui/location/component/select_city/city_search_widget.dart';

class CustomCitySearchWidget extends StatelessWidget {
  const CustomCitySearchWidget({required this.searchController});
  final TextEditingController searchController;
  @override
  Widget build(BuildContext context) {
    return CitySearchWidget(searchController: searchController);
  }
}
