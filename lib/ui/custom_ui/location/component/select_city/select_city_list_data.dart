import 'package:flutter/material.dart';

import '../../../../vendor_ui/location/component/select_city/select_city_list_data.dart';

class CustomSelectCityListData extends StatefulWidget {
  const CustomSelectCityListData({
    Key? key,
    required this.selectedCity,
  }) : super(key: key);
  final String selectedCity;
  @override
  State<StatefulWidget> createState() => _SelectCityListDataState();
}

class _SelectCityListDataState extends State<CustomSelectCityListData> {
  @override
  Widget build(BuildContext context) {
    return SelectCityListData(selectedCity: widget.selectedCity);
  }
}
