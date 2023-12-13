import 'package:flutter/material.dart';

import '../../../vendor_ui/location/view/select_city_view.dart';

class CustomSelectCityView extends StatelessWidget {
  const CustomSelectCityView({
    Key? key,
    required this.selectedCity,
  }) : super(key: key);
  final String selectedCity;
  @override
  Widget build(BuildContext context) {
    return SelectCityView(selectedCity: selectedCity);
  }
}
