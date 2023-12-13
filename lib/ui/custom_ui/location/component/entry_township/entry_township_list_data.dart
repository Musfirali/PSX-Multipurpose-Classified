import 'package:flutter/material.dart';

import '../../../../vendor_ui/location/component/entry_township/entry_township_list_data.dart';

class CustomEntryTownshipListData extends StatefulWidget {
  const CustomEntryTownshipListData(
      {required this.animationController,
      required this.selectedTownshipName});
  final AnimationController animationController;
  final String selectedTownshipName;
  @override
  State<StatefulWidget> createState() => _EntryTownshipListDataState();
}

class _EntryTownshipListDataState extends State<CustomEntryTownshipListData> {
  @override
  Widget build(BuildContext context) {
    return EntryTownshipListData(
        animationController: widget.animationController,
        selectedTownshipName: widget.selectedTownshipName);
  }
}
