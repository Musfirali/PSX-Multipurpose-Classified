import 'package:flutter/material.dart';

import '../../../vendor_ui/location/view/entry_township_view.dart';

class CustomItemEntryFilterTownshipView extends StatefulWidget {
  const CustomItemEntryFilterTownshipView(
      {required this.cityId, required this.selectedTownshipName});

  final String cityId;
  final String selectedTownshipName;
  @override
  State<StatefulWidget> createState() {
    return _ItemEntryLocationTownshipViewState();
  }
}

class _ItemEntryLocationTownshipViewState
    extends State<CustomItemEntryFilterTownshipView> {
  @override
  Widget build(BuildContext context) {
    return ItemEntryFilterTownshipView(
      cityId: widget.cityId,
      selectedTownshipName: widget.selectedTownshipName,
    );
  }
}
