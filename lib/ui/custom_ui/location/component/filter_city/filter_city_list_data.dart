import 'package:flutter/material.dart';

import '../../../../vendor_ui/location/component/filter_city/filter_city_list_data.dart';

class CustomFilterCityListData extends StatefulWidget {
  const CustomFilterCityListData(
      {required this.animationController, required this.selectedCityName});
  final AnimationController animationController;
  final String selectedCityName;
  @override
  State<StatefulWidget> createState() => _FilterCityViewState();
}

class _FilterCityViewState extends State<CustomFilterCityListData> {
  @override
  Widget build(BuildContext context) {
    return FilterCityListData(
        animationController: widget.animationController,
        selectedCityName: widget.selectedCityName,);
  }
}
