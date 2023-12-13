import 'package:flutter/material.dart';

import '../../../vendor_ui/location/view/select_township_view.dart';

class CustomItemLocationTownshipView extends StatelessWidget {
  const CustomItemLocationTownshipView({
    Key? key,
    required this.cityId,
    required this.selectedTownship,
  }) : super(key: key);

  final String cityId;
  final String selectedTownship;

  @override
  Widget build(BuildContext context) {
    return ItemLocationTownshipView(
        cityId: cityId, selectedTownship: selectedTownship);
  }
}
