import 'package:flutter/material.dart';

import '../../../vendor_ui/location/view/filter_city_view.dart';

class CustomFilterCityView extends StatefulWidget {
  const CustomFilterCityView({
    required this.selectedCityName
  });
  final String selectedCityName;
  @override
  State<StatefulWidget> createState() {
    return _FilterCityViewState();
  }
}

class _FilterCityViewState extends State<CustomFilterCityView> {
  @override
  Widget build(BuildContext context) {
    return FilterCityView(
      selectedCityName: widget.selectedCityName,
    );
  }
}
