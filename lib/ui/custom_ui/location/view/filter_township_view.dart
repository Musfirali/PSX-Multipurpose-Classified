import 'package:flutter/material.dart';

import '../../../vendor_ui/location/view/filter_township_view.dart';

class CustomFilterTownshipView extends StatefulWidget {
  const CustomFilterTownshipView(
      {required this.cityId, required this.selectedTownshipName});

  final String cityId;
  final String selectedTownshipName;
  @override
  State<StatefulWidget> createState() {
    return _FilterTownshipViewState();
  }
}

class _FilterTownshipViewState extends State<CustomFilterTownshipView> {
  @override
  Widget build(BuildContext context) {
    return FilterTownshipView(
        cityId: widget.cityId,
        selectedTownshipName: widget.selectedTownshipName);
  }
}