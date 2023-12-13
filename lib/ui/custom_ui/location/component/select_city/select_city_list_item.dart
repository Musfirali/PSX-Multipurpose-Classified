import 'package:flutter/material.dart';

import '../../../../vendor_ui/location/component/select_city/select_city_list_item.dart';

class CustomSelectCityListItem extends StatelessWidget {
  const CustomSelectCityListItem(
      {Key? key,
      required this.itemLocation,
      required this.onTap,
      required this.animationController,
      required this.animation,
      this.isLoading = false,
      required this.isChecked})
      : super(key: key);

  final String? itemLocation;
  final Function? onTap;
  final AnimationController? animationController;
  final Animation<double>? animation;
  final bool isLoading;
  final bool isChecked;

  @override
  Widget build(BuildContext context) {
    return SelectCityListItem(
        itemLocation: itemLocation,
        animation: animation,
        animationController: animationController,
        onTap: onTap,
        isLoading: isLoading,
        isChecked: isChecked);
  }
}
