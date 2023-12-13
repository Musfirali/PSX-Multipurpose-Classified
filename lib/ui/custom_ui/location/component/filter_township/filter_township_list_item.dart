import 'package:flutter/material.dart';

import '../../../../vendor_ui/location/component/filter_township/filter_township_list_item.dart';

class CustomFilterTownshipListItem extends StatelessWidget {
  const CustomFilterTownshipListItem(
      {Key? key,
      required this.itemLocationTownship,
      required this.animationController,
      required this.animation,
      required this.isLoading,
      required this.isSelected,
      required this.onTap})
      : super(key: key);

  final String? itemLocationTownship;
  final AnimationController? animationController;
  final Animation<double>? animation;
  final bool isLoading;
  final bool isSelected;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return FilterTownshipListItem(
        itemLocationTownship: itemLocationTownship,
        animationController: animationController,
        animation: animation,
        isLoading: isLoading,
        isSelected: isSelected,
        onTap: onTap);
  }
}
