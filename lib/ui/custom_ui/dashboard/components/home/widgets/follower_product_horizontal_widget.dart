

import 'package:flutter/material.dart';

import '../../../../../vendor_ui/dashboard/components/home/widgets/follower_product_horizontal_widget.dart';

class CustomItemListFromFollowersHorizontalListWidget extends StatelessWidget {
  const CustomItemListFromFollowersHorizontalListWidget({
    Key? key,
    required this.animationController,
  }) : super(key: key);

  final AnimationController? animationController;

  @override
  Widget build(BuildContext context) {
    return ItemListFromFollowersHorizontalListWidget(
        animationController: animationController);
  }
}

