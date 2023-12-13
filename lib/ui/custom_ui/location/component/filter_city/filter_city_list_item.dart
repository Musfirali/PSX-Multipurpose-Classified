import 'package:flutter/material.dart';

import '../../../../vendor_ui/location/component/filter_city/filter_city_list_item.dart';

class CustomFilterCityListItem extends StatelessWidget {
  const CustomFilterCityListItem(
      {Key? key,
      required this.itemLocationTownship,
      required this.onTap,
      required this.animationController,
      required this.animation,
      required this.isLoading,
      required this.isSelected})
      : super(key: key);

  final String? itemLocationTownship;
  final Function? onTap;
  final AnimationController? animationController;
  final Animation<double>? animation;
  final bool isLoading;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return FilterCityListItem(
        itemLocationTownship: itemLocationTownship,
        onTap: onTap,
        animationController: animationController,
        animation: animation,
        isLoading: isLoading,
        isSelected: isSelected,);
  }
}
