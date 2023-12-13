import 'package:flutter/material.dart';

import '../../../../../core/vendor/viewobject/item_location_township.dart';
import '../../../../vendor_ui/location/component/entry_township/entry_township_list_item.dart';

class CustomEntryTownshipListItem extends StatelessWidget {
  const CustomEntryTownshipListItem(
      {Key? key,
      required this.itemLocationTownship,
      this.animationController,
      this.animation,
      required this.isLoading,
      required this.isSelected})
      : super(key: key);

  final ItemLocationTownship itemLocationTownship;
  final AnimationController? animationController;
  final Animation<double>? animation;
  final bool isLoading;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return EntryTownshipListItem(
      isLoading: isLoading,
      itemLocationTownship: itemLocationTownship,
      animation: animation,
      animationController: animationController,
      isSelected: isSelected,
    );
  }
}