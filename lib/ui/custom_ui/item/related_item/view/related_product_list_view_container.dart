import 'package:flutter/material.dart';

import '../../../../vendor_ui/item/related_item/view/related_product_list_view_container.dart';

class CustomRelatedProductListViewContainer extends StatefulWidget {
  const CustomRelatedProductListViewContainer({
    required this.productId,
    required this.categoryId,
  });
  final String? productId;
  final String categoryId;

  @override
  _RelatedProductListViewState createState() {
    return _RelatedProductListViewState();
  }
}

class _RelatedProductListViewState
    extends State<CustomRelatedProductListViewContainer>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return RelatedProductListViewContainer(
        productId: widget.productId, categoryId: widget.categoryId);
  }
}
