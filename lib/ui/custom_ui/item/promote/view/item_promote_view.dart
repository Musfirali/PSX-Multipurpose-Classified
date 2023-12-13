import 'package:flutter/material.dart';

import '../../../../../core/vendor/viewobject/product.dart';
import '../../../../vendor_ui/item/promote/view/item_promote_view.dart';

class CustomItemPromoteView extends StatefulWidget {
  const CustomItemPromoteView({
    Key? key, 
    required this.product})
      : super(key: key);

  final Product product;
  @override
  _ItemPromoteViewState createState() => _ItemPromoteViewState();
}

class _ItemPromoteViewState extends State<CustomItemPromoteView> {
  @override
  Widget build(BuildContext context) {
    return ItemPromoteView(
      product: widget.product,
    );
  }
}
