import 'package:flutter/material.dart';

import '../../../../vendor_ui/offer/component/widgets/offer_list_view_app_bar.dart';

class CustomOfferListViewAppBar extends StatefulWidget {
  const CustomOfferListViewAppBar(
      {this.selectedIndex = 0,
      this.showElevation = true,
      this.iconSize = 24,
      required this.items,
      required this.onItemSelected})
      : assert(items.length >= 2 && items.length <= 5);

  @override
  State<CustomOfferListViewAppBar> createState() {
    return _OfferListViewAppBarState(
        selectedIndexNo: selectedIndex,
        items: items,
        iconSize: iconSize,
        onItemSelected: onItemSelected);
  }

  final int selectedIndex;
  final double iconSize;
  final bool showElevation;
  final List<OfferListViewAppBarItem> items;
  final ValueChanged<int> onItemSelected;
}

class _OfferListViewAppBarState extends State<CustomOfferListViewAppBar> {
  _OfferListViewAppBarState(
      {required this.items,
      this.iconSize,
      this.selectedIndexNo,
      required this.onItemSelected});

  final double? iconSize;
  List<OfferListViewAppBarItem> items;
  int? selectedIndexNo;
  ValueChanged<int> onItemSelected;

  @override
  Widget build(BuildContext context) {
    return OfferListViewAppBar(
      items: widget.items,
      onItemSelected: widget.onItemSelected,
      iconSize: widget.iconSize,
      selectedIndex: widget.selectedIndex,
      showElevation: widget.showElevation,
    );
  }
}
