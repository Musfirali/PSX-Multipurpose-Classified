import 'package:flutter/material.dart';

import '../../../../core/vendor/viewobject/product.dart';
import '../../../vendor_ui/item/list_item/product_horizontal_list_widget.dart';

class CustomProductHorizontalListWidget extends StatelessWidget {
  const CustomProductHorizontalListWidget(
      {required this.tagKey,
      required this.productList,
      required this.isLoading,
      this.height});
  final List<Product>? productList;
  final String tagKey;
  final bool isLoading;
  final double? height;
  
  @override
  Widget build(BuildContext context) {
    return ProductHorizontalListWidget(
      isLoading: isLoading,
      tagKey: tagKey,
      height: height,
      productList: productList,
    );
  }
}
