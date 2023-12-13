import 'package:flutter/material.dart';

import '../../../../vendor_ui/location/component/filter_township/filter_township_list_data.dart';

class CustomFilterTownshipListData extends StatefulWidget {
  const CustomFilterTownshipListData(
      {required this.animationController, required this.selectedTownshipName});
  final AnimationController animationController;
  final String selectedTownshipName;
  @override
  State<StatefulWidget> createState() => _FilterTownshipViewState();
}

class _FilterTownshipViewState extends State<CustomFilterTownshipListData> {
  @override
  Widget build(BuildContext context) {
    return FilterTownshipListData(
        animationController: widget.animationController,
        selectedTownshipName: widget.selectedTownshipName);
  }
}
