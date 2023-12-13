import 'package:flutter/material.dart';

import '../../../vendor_ui/location/view/entry_city_view.dart';

class CustomItemEntryFilterCityView extends StatefulWidget {
  const CustomItemEntryFilterCityView({
    required this.selectedCityName
  });
  final String selectedCityName;
  @override
  State<StatefulWidget> createState() => _ItemEntryLocationViewState();
}

class _ItemEntryLocationViewState extends State<CustomItemEntryFilterCityView> {
  @override
  Widget build(BuildContext context) {
    return ItemEntryFilterCityView(
      selectedCityName: widget.selectedCityName,
    );
  }
}
