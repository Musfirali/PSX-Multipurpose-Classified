import 'package:flutter/material.dart';

import '../../../../../vendor_ui/item/favourite/component/widgets/favorite_product_list.dart';

class CustomFavoriteProductList extends StatelessWidget {
  const CustomFavoriteProductList({
    required this.animationController,
    required this.isGrid
    });
  final AnimationController animationController;
  final bool isGrid;

  @override
  Widget build(BuildContext context) {
    return FavoriteProductList(
      animationController: animationController,
      isGrid: isGrid
    );
  }
}
