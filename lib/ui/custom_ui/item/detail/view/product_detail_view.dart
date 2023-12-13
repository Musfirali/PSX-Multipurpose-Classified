import 'package:flutter/material.dart';

import '../../../../vendor_ui/item/detail/view/product_detail_view.dart';

class CustomProductDetailView extends StatefulWidget {
  const CustomProductDetailView(
      {required this.productId,
      // required this.catID,
      required this.heroTagImage,
      required this.heroTagTitle});

  final String? productId;
  final String? heroTagImage;
  final String? heroTagTitle;
  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<CustomProductDetailView> {
  @override
  Widget build(BuildContext context) {
    return ProductDetailView(
        productId: widget.productId,
        heroTagImage: widget.heroTagImage,
        heroTagTitle: widget.heroTagTitle);
  }
}
