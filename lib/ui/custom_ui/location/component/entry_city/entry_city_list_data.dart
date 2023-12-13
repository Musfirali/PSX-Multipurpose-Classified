import 'package:flutter/material.dart';

import '../../../../vendor_ui/location/component/entry_city/entry_city_list_data.dart';

class CustomEntryCityListData extends StatefulWidget {
  const CustomEntryCityListData(
      {required this.animationController, required this.selectedCityName});
  final AnimationController animationController;
  final String selectedCityName;
  @override
  State<StatefulWidget> createState() => _EntryCityListDataState();
}

class _EntryCityListDataState extends State<CustomEntryCityListData> {
  @override
  Widget build(BuildContext context) {
    return EntryCityListData(
      animationController: widget.animationController,
      selectedCityName: widget.selectedCityName,
    );
  }
}