import 'package:flutter/material.dart';

import '../../../../../vendor_ui/item/related_item/component/vertical/related_product_list_view.dart';

class CustomRelatedProductList extends StatelessWidget {
  const CustomRelatedProductList({
    required this.animationController});
  final AnimationController animationController;
  @override
  Widget build(BuildContext context) {
    return RelatedProductList(animationController: animationController);
  }
}
