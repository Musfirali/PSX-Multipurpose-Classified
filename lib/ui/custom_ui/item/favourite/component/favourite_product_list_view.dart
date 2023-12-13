import 'package:flutter/material.dart';

import '../../../../vendor_ui/item/favourite/component/favourite_product_list_view.dart';

class CustomFavouriteProductListView extends StatefulWidget {
  const CustomFavouriteProductListView({
      Key? key, 
      required this.animationController,
      required this.scaffoldKey,
      required this.fromActivityLog})
    : super(key: key);

  final AnimationController animationController;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final bool fromActivityLog;

  @override
  _FavouriteProductListView createState() => _FavouriteProductListView();
}

class _FavouriteProductListView extends State<CustomFavouriteProductListView> {
  @override
  Widget build(BuildContext context) {
    return FavouriteProductListView(
        animationController: widget.animationController,
        scaffoldKey: widget.scaffoldKey,
        fromActivityLog: widget.fromActivityLog);
  }
}
