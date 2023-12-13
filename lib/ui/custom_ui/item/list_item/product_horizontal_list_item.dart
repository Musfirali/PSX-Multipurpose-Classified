import 'package:flutter/material.dart';

import '../../../../core/vendor/viewobject/product.dart';
import '../../../vendor_ui/item/list_item/product_horizontal_list_item.dart';

class CustomProductHorizontalListItem extends StatelessWidget {
  const CustomProductHorizontalListItem({
    Key? key,
    required this.product,
    required this.tagKey,
    this.isLoading = false,
  }) : super(key: key);

  final Product product;
  final String tagKey;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return ProductHorizontalListItem(
      product: product,
      tagKey: tagKey,
      isLoading: isLoading,
    );
  }
}
