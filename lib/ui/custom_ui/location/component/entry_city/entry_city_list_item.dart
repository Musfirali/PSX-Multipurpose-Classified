import 'package:flutter/material.dart';

import '../../../../../core/vendor/viewobject/item_location.dart';
import '../../../../vendor_ui/location/component/entry_city/entry_city_list_item.dart';

class CustomEntryCityListItem extends StatelessWidget {
  const CustomEntryCityListItem(
      {Key? key,
      required this.itemLocation,
      this.animationController,
      this.animation,
      required this.isLoading,
      required this.isSelected})
      : super(key: key);

  final ItemLocation itemLocation;
  final AnimationController? animationController;
  final Animation<double>? animation;
  final bool isLoading;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return EntryCityListItem(
      itemLocation: itemLocation,
      isLoading: isLoading,
      animation: animation,
      animationController: animationController,
      isSelected: isSelected,
    );
  }
}
