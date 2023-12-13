import 'package:flutter/material.dart';
import 'package:psxmpc/ui/vendor_ui/item/list_item/product_price_widget.dart';
import '../../../../../../../core/vendor/viewobject/product.dart';


class CustomProductPriceWidget extends StatelessWidget {
  const CustomProductPriceWidget({
    Key? key,
    required this.product,
    required this.tagKey,
  }) : super(key: key);

  final Product product;
  final String tagKey;

  @override
  Widget build(BuildContext context) {

    return ProductPriceWidget(product: product,tagKey: tagKey,);
  }

}
