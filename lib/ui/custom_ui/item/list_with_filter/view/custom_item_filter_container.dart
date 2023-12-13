import 'package:flutter/material.dart';

import '../../../../../core/vendor/viewobject/holder/product_parameter_holder.dart';
import '../../../../vendor_ui/item/list_with_filter/view/item_filter_container.dart';

class CustomItemFilterContainer extends StatefulWidget {
  const CustomItemFilterContainer({
    Key? key,
    required this.productParameterHolder,
  }) : super(key: key);
  final ProductParameterHolder productParameterHolder;

  @override
  State<CustomItemFilterContainer> createState() =>
      _CustomItemFilterContainerState();
}

class _CustomItemFilterContainerState extends State<CustomItemFilterContainer> {
  @override
  Widget build(BuildContext context) {
    return ItemFilterContainer(
        productParameterHolder: widget.productParameterHolder);
  }
}
