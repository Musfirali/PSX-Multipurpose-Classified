import 'package:flutter/material.dart';

import '../../../../vendor_ui/location/component/select_township/select_township_list_data.dart';

class CustomSelectTownshipListData extends StatefulWidget {
  const CustomSelectTownshipListData({
    Key? key,
    required this.selectedTownship,
  }) : super(key: key);
  final String selectedTownship;
  @override
  State<StatefulWidget> createState() => _SelectTownshipListDataState();
}

class _SelectTownshipListDataState extends State<CustomSelectTownshipListData> {
  @override
  Widget build(BuildContext context) {
    return SelectTownshipListData(selectedTownship: widget.selectedTownship);
  }
}
